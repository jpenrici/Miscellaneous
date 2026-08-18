#!/usr/bin/env perl
#
# Name:        cpp_inspector.pl
# Description: Generates a CodeQuery database (.db), a text overview report,
#              a CSV call-relationship export, and an SVG call graph for
#              C/C++ projects by automatically running ctags, cscope and
#              cqmakedb.
# Usage:       perl cpp_inspector.pl [--in=<path>] [--out=<path>] [--yes]
#                                     [--kind=<letters>]
#                                     [--no_label] [--no_line] [--no_call]
# Requirements: ctags, cscope, cqmakedb
#
# Reference:
#   https://ruben2020.github.io/codequery/
#

use strict;
use warnings;
use feature 'say';

use Cwd qw(abs_path);

use File::Basename qw(basename dirname);
use File::Find     qw(find);
use File::Path     qw(make_path);
use File::Spec;

use Getopt::Long qw(GetOptions);

use constant {
    SOURCE_EXT_RE  => qr/\.(?:c|cpp|cxx|cc|h|hpp|hxx|hh)$/i,
    SKIP_DIR_RE    => qr/^(?:\.git|\.svn|\.hg|build|cmake-build.*|out)$/i,
    DEFAULT_OUTDIR => 'output_codequery',
};

# Kinds we care about when scanning ctags output:
# f=function, c=class, p=prototype, m=member.
# Sort priority controls the order in which they appear in the report.
my %KIND_LABEL = (
    f => 'Function',
    p => 'Prototype',
    m => 'Member',
    c => 'Class',
);
my %KIND_PRIORITY = ( f => 1, p => 2, m => 3, c => 4 );

# Canonical order for --kind selections, LEGEND, and SUMMARY output.
my @ALL_KINDS = qw(f p m c);

main();
exit 0;

# ----------------------------------------------------------------------
sub main {
    refuse_to_run_as_root();

    my $opts = parse_arguments(@ARGV);
    die usage() if ( $opts->{in} eq "" );
    my $kind_filter = normalize_kind_selection( $opts->{kind} );

    require_tools_or_die(qw(ctags cscope cqmakedb));

    my $project_dir = resolve_project_dir( $opts->{in} );
    my $output_dir  = resolve_output_dir( $opts->{out}, $opts->{yes} );

    say "[*] Scanning project directory: $project_dir";
    say "[*] Saving output artifacts to: $output_dir\n";

    my @source_files = collect_source_files($project_dir);
    my $total_files  = scalar @source_files;
    say "[1/8] Found $total_files C/C++ source/header files.";
    die "No C/C++ files found in '$project_dir'.\n" unless $total_files;

    my $cscope_files_path = File::Spec->catfile( $output_dir, 'cscope.files' );
    write_file_list( $cscope_files_path, \@source_files );
    say "[2/8] Wrote absolute file list to 'cscope.files'.";

    my $tags_path       = File::Spec->catfile( $output_dir, 'tags' );
    my $cscope_out_path = File::Spec->catfile( $output_dir, 'cscope.out' );
    my $db_path         = File::Spec->catfile( $output_dir, 'codequery.db' );
    my $report_path =
      File::Spec->catfile( $output_dir,
        report_filename( $opts, $kind_filter ) );
    my $csv_path = File::Spec->catfile( $output_dir, 'cpp_relationships.csv' );
    my $svg_path = File::Spec->catfile( $output_dir, 'cpp_call_graph.svg' );

    say "[3/8] Running ctags...";
    run_ctags( $cscope_files_path, $tags_path );

    say "[4/8] Running cscope...";
    run_cscope( $cscope_files_path, $cscope_out_path );

    say "[5/8] Generating CodeQuery database (.db)...";
    run_cqmakedb( $db_path, $cscope_out_path, $tags_path );

    say "[6/8] Parsing tags output...";
    my %definitions = parse_tags($tags_path);

    say "[7/8] Mapping caller/callee relationships via cscope...";
    my %callers_of = build_caller_map( \%definitions, $cscope_out_path );

    say "[8/8] Writing text, CSV and SVG reports...";
    write_text_report(
        $report_path,
        \%definitions,
        \%callers_of,
        $project_dir,
        {
            hide_labels    => $opts->{no_label},
            hide_lines     => $opts->{no_line},
            hide_called_by => $opts->{no_call},
            kind           => $kind_filter,
        }
    );
    write_csv_report( $csv_path, \%callers_of );
    write_svg_call_graph( $svg_path, \%callers_of );

    print_summary( $db_path, $report_path, $csv_path, $svg_path );
    return;
}

# ----------------------------------------------------------------------
# Setup / validation helpers
# ----------------------------------------------------------------------

sub refuse_to_run_as_root {
    return unless $> == 0;
    die
"Error: Running this script as 'root' is not allowed for security reasons.\n"
      . "Please run it as a normal user.\n";
}

sub parse_arguments {
    local @ARGV = @_;

    my %opts = (
        in       => "",
        out      => DEFAULT_OUTDIR,
        no_line  => 0,
        no_label => 0,
        no_call  => 0,
        kind     => join( '', @ALL_KINDS ),    # default: fpmc (all kinds)
        yes      => 0,
    );
    GetOptions(
        'in=s'     => \$opts{in},
        'out=s'    => \$opts{out},
        'no_line'  => \$opts{no_line},
        'no_label' => \$opts{no_label},
        'no_call'  => \$opts{no_call},
        'kind=s'   => \$opts{kind},
        'yes|y'    => \$opts{yes},
        'help|h'   => sub { print usage(); exit 0; },
    ) or die usage();

    return \%opts;
}

# Validates the --kind value (a string of any combination of f/p/m/c) and
# returns an arrayref of the selected kinds in canonical order (f p m c),
# regardless of the order/repetition the user typed them in. Dies with a
# clear message on invalid or empty input.
sub normalize_kind_selection {
    my ($raw) = @_;

    my %requested = map  { $_ => 1 } split //, lc( $raw // '' );
    my @invalid   = grep { !exists $KIND_LABEL{$_} } keys %requested;

    die "Error: invalid --kind value(s): "
      . join( ', ', sort @invalid )
      . ". Valid kinds are: "
      . join( ' ', @ALL_KINDS ) . ".\n"
      if @invalid;
    die "Error: --kind must include at least one of: "
      . join( ' ', @ALL_KINDS ) . ".\n"
      unless %requested;

    return [ grep { $requested{$_} } @ALL_KINDS ];
}

sub usage {
    return <<"HELP";
Usage:
  perl $0 [options]

Options:
  --in=<path>    Path to the C++ project directory to scan (default: current directory)
  --out=<path>   Path to the output directory where artifacts will be saved (default: @{[ DEFAULT_OUTDIR ]})
  --kind=<letters>  Keep only the given symbol kinds in cpp_relationships.txt (default: fpmc)
                     f=Function  p=Prototype  m=Member  c=Class
                     e.g. --kind=fp keeps functions and prototypes, hides members/classes
  --no_label     Hide the [f/p/m/c] kind label for each symbol in cpp_relationships.txt
  --no_line      Hide the "| Line: N" suffix for each symbol in cpp_relationships.txt
  --no_call      Hide the "Called by:" section in cpp_relationships.txt
  --yes, -y      Skip the confirmation prompt when --out doesn't exist yet
                  (creates it automatically - useful for scripts/CI)
  --help, -h     Display this help message and exit

Note:
  The text report filename gets a suffix for each active flag above, e.g.:
    cpp_relationships.txt
    cpp_relationships__kind_fp.txt
    cpp_relationships__kind_fp__no_label__no_call.txt

Examples:
  perl $0 --in=/path/to/cpp/project --out=/path/to/output_folder
  perl $0 --in=./my_project --kind=fp --no_line
  perl $0 --in=./my_project --out=./ci_output --yes   # non-interactive (CI)
HELP
}

# Looks up an executable in $ENV{PATH} without shelling out to `which`,
# so the script has one less external-command dependency.
sub find_tool_in_path {
    my ($tool) = @_;
    for my $dir ( split /:/, $ENV{PATH} // '' ) {
        my $candidate = File::Spec->catfile( $dir, $tool );
        return $candidate if -x $candidate && !-d $candidate;
    }
    return undef;
}

sub require_tools_or_die {
    my @tools   = @_;
    my @missing = grep { !find_tool_in_path($_) } @tools;

    return unless @missing;
    die "Error: The following required tool(s) are missing from your PATH: "
      . join( ', ', @missing )
      . ".\nPlease install them before running this script.\n";
}

sub resolve_project_dir {
    my ($raw_path) = @_;
    $raw_path = glob($raw_path) if defined $raw_path && $raw_path =~ /^~/;
    my $abs = abs_path($raw_path)
      or die "Error: Invalid project directory path: $raw_path\n";
    die "Error: The project directory '$abs' does not exist.\n"
      . "Use --help for usage information.\n"
      unless -d $abs;
    return $abs;
}

sub resolve_output_dir {
    my ( $raw_path, $auto_yes ) = @_;
    $raw_path = glob($raw_path) if defined $raw_path && $raw_path =~ /^~/;

    unless ( -d $raw_path ) {

        # Show the path as it would resolve *before* creating anything, so a
        # typo (e.g. "~/Download/Result" instead of "~/Downloads/Result") is
        # caught here instead of silently producing a new, empty directory.
        my $would_be_path = File::Spec->rel2abs($raw_path);
        confirm_or_die(
            "[?] Output directory does not exist: $would_be_path\n"
              . "    Create it now? [y/N] ",
            $auto_yes
        );
        make_path($raw_path);
    }

    return abs_path($raw_path);
}

# Prompts the user with a yes/no question and dies (aborting the whole
# script) on anything other than an explicit "y"/"yes". Skips the prompt
# entirely when $auto_yes is true (--yes/-y), for use in scripts/CI where
# no interactive terminal is attached. If STDIN isn't interactive and
# --yes wasn't given, this fails safe (treated as "no") rather than
# hanging or silently proceeding.
sub confirm_or_die {
    my ( $prompt, $auto_yes ) = @_;
    return if $auto_yes;

    print $prompt;
    my $answer = <STDIN>;
    $answer = defined $answer ? lc($answer) : 'n';
    chomp $answer;

    die "Aborted: output directory was not created.\n"
      unless $answer =~ /^y(es)?$/;
    return;
}

# Builds the text report's filename, appending a suffix for each active
# formatting flag (in a fixed order) so that runs with different flags
# don't overwrite each other's report in the same output directory. E.g.:
#   cpp_relationships.txt
#   cpp_relationships__kind_fp.txt
#   cpp_relationships__kind_fp__no_label__no_call.txt
sub report_filename {
    my ( $opts, $kind_filter ) = @_;

    my @suffix;
    push @suffix, 'kind_' . join( '', @$kind_filter )
      if @$kind_filter != @ALL_KINDS;
    push @suffix, 'no_label' if $opts->{no_label};
    push @suffix, 'no_line'  if $opts->{no_line};
    push @suffix, 'no_call'  if $opts->{no_call};

    my $name = 'cpp_relationships';
    $name .= '__' . join( '__', @suffix ) if @suffix;
    return "$name.txt";
}

# ----------------------------------------------------------------------
# File collection
# ----------------------------------------------------------------------

# Recursively collects C/C++ source and header files, skipping common
# non-source directories (VCS metadata, build output, etc.).
sub collect_source_files {
    my ($project_dir) = @_;

    my @source_files;
    find(
        {
            wanted => sub {
                if ( -d $_ ) {
                    my $dir_name = basename($_);
                    if ( $dir_name =~ /@{[ SKIP_DIR_RE ]}/ ) {
                        $File::Find::prune = 1;
                        return;
                    }
                }
                push @source_files, abs_path($_)
                  if -f $_ && /@{[ SOURCE_EXT_RE ]}/;
            },
            no_chdir => 1,
        },
        $project_dir
    );

    return sort @source_files;
}

sub write_file_list {
    my ( $path, $files ) = @_;
    open my $fh, '>', $path or die "Could not create $path: $!\n";
    print {$fh} "$_\n" for @$files;
    close $fh or die "Could not write $path: $!\n";
    return;
}

# ----------------------------------------------------------------------
# External tool invocations
# ----------------------------------------------------------------------

sub run_ctags {
    my ( $cscope_files_path, $tags_path ) = @_;
    system(
        'ctags',            '-R', '--c++-kinds=+p',
        '--fields=+iaS',    '-n', '-L',
        $cscope_files_path, '-f', $tags_path,
      ) == 0
      or warn "Warning: ctags exited with a non-zero status ($?).\n";
    return;
}

sub run_cscope {
    my ( $cscope_files_path, $cscope_out_path ) = @_;
    system( 'cscope', '-b', '-c', '-q', '-i', $cscope_files_path,
        '-f', $cscope_out_path, ) == 0
      or warn "Warning: cscope exited with a non-zero status ($?).\n";
    return;
}

sub run_cqmakedb {
    my ( $db_path, $cscope_out_path, $tags_path ) = @_;
    system( 'cqmakedb', '-s', $db_path, '-c', $cscope_out_path,
        '-t', $tags_path, '-p', ) == 0
      or die "Critical Error: Failed to run cqmakedb.\n";
    return;
}

# ----------------------------------------------------------------------
# ctags parsing
# ----------------------------------------------------------------------

# Returns %definitions{file}{symbol_name} = { kind, line, signature }
sub parse_tags {
    my ($tags_path) = @_;

    my %definitions;
    open my $fh, '<', $tags_path or die "[-] Cannot open tags file: $!\n";
    while ( my $line = <$fh> ) {
        next if $line =~ /^!/;
        chomp $line;

        my ( $name, $file, $line_num, $kind, @rest ) = split /\t/, $line;
        next unless defined $kind && exists $KIND_LABEL{$kind};

        ($line_num) = $line_num =~ /(\d+)/;    # strip ;" and other artifacts

        my ($signature) = map { /^signature:(.*)/ ? $1 : () } @rest;
        $signature //= '';

        $definitions{$file}{$name} = {
            kind      => $kind,
            line      => $line_num,
            signature => $signature,
        };
    }
    close $fh;

    return %definitions;
}

# ----------------------------------------------------------------------
# Call graph construction
# ----------------------------------------------------------------------

# For every known symbol, ask cscope "who calls this function?"
# (cscope line-mode -L -3), and record the callers keyed by callee.
sub build_caller_map {
    my ( $definitions, $cscope_out_path ) = @_;

    my %callers_of;    # callee_name => [ { caller, file, line }, ... ]

    for my $file ( keys %$definitions ) {
        for my $func_name ( keys %{ $definitions->{$file} } ) {
            next
              if $definitions->{$file}{$func_name}{kind} eq
              'c';    # classes aren't "called"

            my @callers = find_callers( $cscope_out_path, $func_name );
            push @{ $callers_of{$func_name} }, @callers if @callers;
        }
    }

    return %callers_of;
}

sub find_callers {
    my ( $cscope_out_path, $func_name ) = @_;

    open my $cscope_fh, '-|', 'cscope', '-d', '-f', $cscope_out_path, '-L',
      '-3', $func_name
      or return ();

    my @callers;
    while ( my $line = <$cscope_fh> ) {
        chomp $line;

        # cscope -L output format: file caller_function line_number code
        next unless $line =~ /^(\S+)\s+(\S+)\s+(\d+)\s+(.*)$/;
        my ( $file, $caller_func, $call_line, undef ) = ( $1, $2, $3, $4 );
        next if $caller_func eq $func_name;    # skip self-recursion noise
        push @callers,
          { caller => $caller_func, file => $file, line => $call_line };
    }
    close $cscope_fh;

    return @callers;
}

# ----------------------------------------------------------------------
# Report generation
# ----------------------------------------------------------------------

sub write_text_report {
    my ( $report_path, $definitions, $callers_of, $project_dir, $format ) = @_;
    $format //= {};
    my $hide_labels    = $format->{hide_labels};
    my $hide_lines     = $format->{hide_lines};
    my $hide_called_by = $format->{hide_called_by};
    my $kind_filter    = $format->{kind} // \@ALL_KINDS;
    my %allowed_kind   = map { $_ => 1 } @$kind_filter;

    my $path_base = defined $project_dir ? dirname($project_dir) : undef;

    open my $fh, '>', $report_path
      or die "[-] Cannot open text analysis file: $!\n";

    print {$fh} "=== C++ PROJECT RELATIONSHIPS OVERVIEW ===\n\n";

    unless ($hide_labels) {
        print {$fh} "LEGEND:\n";
        for my $kind (@$kind_filter) {
            printf {$fh} "  [%s] %-10s - %s\n", $kind, $KIND_LABEL{$kind},
              kind_description($kind);
        }
        print {$fh} ( '=' x 50 ) . "\n\n";
    }

    my %counts = count_kinds($definitions);
    print {$fh} "SUMMARY:\n";
    my $total = 0;
    for my $kind (@$kind_filter) {
        my $n = $counts{$kind} // 0;
        $total += $n;
        printf {$fh} "  [%s] %-10s : %d\n", $kind, $KIND_LABEL{$kind}, $n;
    }
    printf {$fh} "  %-14s : %d\n", 'Total', $total;
    print {$fh} ( '=' x 50 ) . "\n\n";

    for my $file ( sort keys %$definitions ) {
        my @names =
          grep { $allowed_kind{ $definitions->{$file}{$_}{kind} } }
          sorted_symbol_names( $definitions->{$file} );
        next unless @names;    # skip files with nothing left after filtering

        print {$fh} "FILE: " . shorten_path( $file, $path_base ) . "\n";

        for my $name (@names) {
            my $info = $definitions->{$file}{$name};

            my @parts;
            push @parts, "[$info->{kind}]" unless $hide_labels;
            push @parts, $name;
            push @parts, $info->{signature} if length $info->{signature};
            push @parts, "| Line: $info->{line}" unless $hide_lines;
            print {$fh} '  ' . join( ' ', @parts ) . "\n";

            next if $hide_called_by;
            next unless exists $callers_of->{$name};

            print {$fh} "    Called by:\n";
            my %seen;
            for my $call ( @{ $callers_of->{$name} } ) {
                next if $seen{ $call->{caller} }++;
                my $call_file = shorten_path( $call->{file}, $path_base );
                print {$fh}
                  "      <- $call->{caller} | at $call_file:$call->{line}\n";
            }
        }
        print {$fh} "\n" . ( '-' x 40 ) . "\n\n";
    }

    close $fh;
    return;
}

sub shorten_path {
    my ( $path, $base_dir ) = @_;
    return $path unless defined $path && defined $base_dir;

    my $relative = eval { File::Spec->abs2rel( $path, $base_dir ) };
    return ( defined $relative && length $relative ) ? $relative : $path;
}

sub count_kinds {
    my ($definitions) = @_;
    my %counts;
    for my $file ( keys %$definitions ) {
        for my $name ( keys %{ $definitions->{$file} } ) {
            $counts{ $definitions->{$file}{$name}{kind} }++;
        }
    }
    return %counts;
}

sub kind_description {
    my ($kind) = @_;
    my %desc = (
        f => 'Function definition',
        p => 'Function or method declaration',
        m => 'Class member variable or method',
        c => 'Class or struct definition',
    );
    return $desc{$kind} // '';
}

sub sorted_symbol_names {
    my ($file_defs) = @_;
    return sort {
        my $p_a = $KIND_PRIORITY{ $file_defs->{$a}{kind} } // 99;
        my $p_b = $KIND_PRIORITY{ $file_defs->{$b}{kind} } // 99;
        $p_a <=> $p_b || $a cmp $b
    } keys %$file_defs;
}

# CSV export: one row per unique (callee, caller) edge, easy to load into
# spreadsheets or graph-analysis tools.
sub write_csv_report {
    my ( $csv_path, $callers_of ) = @_;

    open my $fh, '>', $csv_path or die "[-] Cannot open CSV file: $!\n";
    print {$fh} "callee,caller,file,line\n";

    for my $callee ( sort keys %$callers_of ) {
        my %seen;
        for my $call ( @{ $callers_of->{$callee} } ) {
            my $key = "$call->{caller}\0$call->{file}\0$call->{line}";
            next if $seen{$key}++;
            print {$fh} join( ',',
                csv_escape($callee),
                csv_escape( $call->{caller} ),
                csv_escape( $call->{file} ),
                csv_escape( $call->{line} ),
              ),
              "\n";
        }
    }

    close $fh;
    return;
}

sub csv_escape {
    my ($value) = @_;
    $value //= '';
    if ( $value =~ /[",\n]/ ) {
        $value =~ s/"/""/g;
        return qq{"$value"};
    }
    return $value;
}

# SVG export: a lightweight, dependency-free circular call graph.
# Nodes are the functions that participate in at least one call edge;
# edges are drawn as straight lines with an arrowhead at the callee.
sub write_svg_call_graph {
    my ( $svg_path, $callers_of ) = @_;

    my %nodes;
    my @edges;    # [ caller, callee ]
    for my $callee ( keys %$callers_of ) {
        my %seen;
        for my $call ( @{ $callers_of->{$callee} } ) {
            next if $seen{ $call->{caller} }++;
            $nodes{$callee}++;
            $nodes{ $call->{caller} }++;
            push @edges, [ $call->{caller}, $callee ];
        }
    }

    open my $fh, '>', $svg_path or die "[-] Cannot open SVG file: $!\n";

    unless (%nodes) {
        print {$fh}
          svg_wrap( '<text x="20" y="30" font-family="sans-serif" '
              . 'font-size="14">No call relationships were found.</text>' );
        close $fh;
        return;
    }

    my @names  = sort keys %nodes;
    my $count  = scalar @names;
    my $radius = 120 + 12 * $count;
    my ( $cx, $cy ) = ( $radius + 60, $radius + 60 );
    my $size = 2 * $radius + 120;

    my %pos;
    for my $i ( 0 .. $#names ) {
        my $angle = 2 * 3.14159265 * $i / $count;
        $pos{ $names[$i] } = {
            x => $cx + $radius * cos($angle),
            y => $cy + $radius * sin($angle),
        };
    }

    my @svg_parts;
    push @svg_parts, marker_def();

    for my $edge (@edges) {
        my ( $caller, $callee ) = @$edge;
        my ( $x1,     $y1 )     = @{ $pos{$caller} }{qw(x y)};
        my ( $x2,     $y2 )     = @{ $pos{$callee} }{qw(x y)};
        push @svg_parts,
          sprintf( '<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" '
              . 'stroke="#888" stroke-width="1.5" marker-end="url(#arrow)" />',
            $x1, $y1, $x2, $y2 );
    }

    for my $name (@names) {
        my ( $x, $y ) = @{ $pos{$name} }{qw(x y)};
        push @svg_parts,
          sprintf( '<circle cx="%.1f" cy="%.1f" r="6" fill="#4a90d9" />',
            $x, $y );
        push @svg_parts,
          sprintf(
            '<text x="%.1f" y="%.1f" font-family="sans-serif" font-size="11" '
              . 'text-anchor="middle">%s</text>',
            $x, $y - 10, svg_escape($name) );
    }

    print {$fh} svg_wrap( join( "\n", @svg_parts ), $size, $size );
    close $fh;
    return;
}

sub marker_def {
    return <<'SVG';
<defs>
  <marker id="arrow" markerWidth="10" markerHeight="10" refX="8" refY="3"
          orient="auto" markerUnits="strokeWidth">
    <path d="M0,0 L0,6 L9,3 z" fill="#888" />
  </marker>
</defs>
SVG
}

sub svg_wrap {
    my ( $body, $width, $height ) = @_;
    $width  //= 600;
    $height //= 400;
    return <<"SVG";
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height"
     viewBox="0 0 $width $height">
  <rect width="100%" height="100%" fill="white" />
$body
</svg>
SVG
}

sub svg_escape {
    my ($text) = @_;
    $text =~ s/&/&amp;/g;
    $text =~ s/</&lt;/g;
    $text =~ s/>/&gt;/g;
    return $text;
}

# ----------------------------------------------------------------------
sub print_summary {
    my ( $db_path, $report_path, $csv_path, $svg_path ) = @_;
    print <<"SUMMARY";

[SUCCESS] Pipeline completed successfully!
--------------------------------------------------
1. CodeQuery GUI:
   codequery $db_path

2. Text overview report:
   $report_path

3. CSV relationship export:
   $csv_path

4. SVG call graph:
   $svg_path
--------------------------------------------------
SUMMARY
    return;
}
