#!/usr/bin/env perl
#
# Name:        cpp_inspector.pl
# Description: Generates a CodeQuery database (.db) and a text overview report
#              for C/C++ projects by automatically running ctags, cscope, and cqmakedb.
# Usage:       perl cpp_inspector.pl [in=/path/to/project] [out=/path/to/output]
# Requirements: ctags, cscope, cqmakedb
#
# Reference:
#   https://ruben2020.github.io/codequery/
#

use strict;
use warnings;

use File::Spec;
use File::Path qw(make_path);
use File::Find;

use Cwd qw(abs_path);

# Check if running as root
if ( $> == 0 ) {
    die
"Error: Running this script as 'root' is not allowed for security reasons.\nPlease run it as a normal user.\n";
}

# Check if required external tools are available in the system PATH
my @required_tools = ( 'ctags', 'cscope', 'cqmakedb' );
my @missing_tools;

foreach my $tool (@required_tools) {
    my $path = qx(which $tool 2>/dev/null);
    chomp($path);
    if ( !$path ) {
        push @missing_tools, $tool;
    }
}

if (@missing_tools) {
    die "Error: The following required tool(s) are missing from your PATH: "
      . join( ', ', @missing_tools )
      . ".\nPlease install them before running this script.\n";
}

# Display help message if requested
if ( grep { $_ eq '--help' || $_ eq '-h' } @ARGV ) {
    print <<"HELP";
Usage:
  perl $0 [options]

Options:
  in=<path>   Path to the C++ project directory to scan (default: current directory)
  out=<path>  Path to the output directory where artifacts will be saved (default: output_codequery)
  --help, -h  Display this help message and exit

Example:
  perl $0 in=/path/to/cpp/project out=/path/to/output_folder
HELP
    exit 0;
}

# Parse command line arguments for in=<path> and out=<path>
my ( $project_dir, $output_dir );

foreach my $arg (@ARGV) {
    if ( $arg =~ /^in=(.+)$/ ) {
        $project_dir = $1;
    }
    elsif ( $arg =~ /^out=(.+)$/ ) {
        $output_dir = $1;
    }
}

# Default values if not provided
$project_dir ||= '.';
$output_dir  ||= 'output_codequery';

# Convert to absolute paths safely
$project_dir = abs_path($project_dir)
  or die "Error: Invalid project directory path: $project_dir\n";
make_path($output_dir) unless -d $output_dir;
$output_dir = abs_path($output_dir);

unless ( -d $project_dir ) {
    die
"Error: The project directory '$project_dir' does not exist.\nUse --help for usage information.\n";
}

print "[*] Scanning project directory: $project_dir\n";
print "[*] Saving output artifacts to: $output_dir\n\n";

# 1. Recursively collect C/C++ source files with absolute paths
my @source_files;
find(
    {
        wanted => sub {
            if (/\.(c|cpp|cxx|cc|h|hpp|hxx|hh)$/i) {
                push @source_files, abs_path($_);
            }
        },
        no_chdir => 1
    },
    $project_dir
);

my $total_files = scalar @source_files;
print "[1/6] Found $total_files C/C++ source/header files.\n";

if ( $total_files == 0 ) {
    die "No C/C++ files found in the specified directory.\n";
}

# 2. Generate the absolute file list for cscope
my $cscope_files_path = File::Spec->catfile( $output_dir, 'cscope.files' );

open( my $fh_files, '>', $cscope_files_path )
  or die "Could not create $cscope_files_path: $!\n";
foreach my $file (@source_files) {
    print $fh_files "$file\n";
}
close($fh_files);
print "[2/6] Successfully generated absolute paths in 'cscope.files'.\n";

# 3. Run ctags and cscope targeted to the output directory
print "[3/6] Running ctags and cscope...\n";

my $tags_path       = File::Spec->catfile( $output_dir, 'tags' );
my $cscope_out_path = File::Spec->catfile( $output_dir, 'cscope.out' );
my $db_path         = File::Spec->catfile( $output_dir, 'codequery.db' );
my $analysis_file = File::Spec->catfile( $output_dir, 'cpp_relationships.txt' );

# Run ctags with absolute paths and output redirection (including signature fields)
system(
    'ctags',            '-R', '--c++-kinds=+p',
    '--fields=+iaS',    '-n', '-L',
    $cscope_files_path, '-f', $tags_path
  ) == 0
  or warn "Warning: ctags exited with error code ($?).\n";

# Run cscope using the absolute file list (-i)
system( 'cscope', '-b', '-c', '-q', '-i', $cscope_files_path, '-f',
    $cscope_out_path ) == 0
  or warn "Warning: cscope exited with error code ($?).\n";

# 4. Convert into the CodeQuery database format
print "[4/6] Generating CodeQuery database (.db)...\n";
system( 'cqmakedb', '-s', $db_path, '-c', $cscope_out_path, '-t', $tags_path,
    '-p' ) == 0
  or die "Critical Error: Failed to run cqmakedb.\n";

# 5. Parse tags output for text overview
print "[5/6] Parsing tags and building text relationships...\n";
my %definitions;

open( my $tag_fh, '<', $tags_path ) or die "[-] Cannot open tags file: $!";
while ( my $line = <$tag_fh> ) {
    next if $line =~ /^!/;
    chomp($line);
    my ( $name, $file, $line_num, $kind, @rest ) = split( /\t/, $line );

    # Clean up line_num to keep only digits (removes ;" and extra artifacts)
    $line_num =~ s/\D//g;

    # Kind definitions: f=function, c=class, p=prototype, m=member
    next unless $kind =~ /^(f|c|p|m)$/;

    my $signature = '';
    foreach my $field (@rest) {
        if ( $field =~ /^signature:(.*)/ ) {
            $signature = $1;
        }
    }

    $definitions{$file}{$name} = {
        kind      => $kind,
        line      => $line_num,
        signature => $signature
    };
}
close($tag_fh);

# 6. Map function calls using Cscope and generate text report
print "[6/6] Mapping call relationships and generating text report...\n";
my %calls;
foreach my $file ( keys %definitions ) {
    foreach my $func_name ( keys %{ $definitions{$file} } ) {

        # Query cscope in line mode (-L -1) for functions called by $func_name
        my $cscope_result =
          `cscope -d -f $cscope_out_path -L -1 $func_name 2>/dev/null`;
        my @call_lines = split( /\n/, $cscope_result );

        foreach my $c_line (@call_lines) {
            if ( $c_line =~ /^(\S+)\s+(\S+)\s+(\d+)\s+(.*)$/ ) {
                my ( $target_file, $caller_func, $call_line, $code ) =
                  ( $1, $2, $3, $4 );
                next if $caller_func eq $func_name;
                push @{ $calls{$caller_func} },
                  {
                    callee => $func_name,
                    file   => $target_file,
                    line   => $call_line
                  };
            }
        }
    }
}

# Define priority map for sorting kinds: f (function) first, then p (prototype), m (member), c (class), others last
my %kind_priority = (
    'f' => 1,
    'p' => 2,
    'm' => 3,
    'c' => 4,
);

# Write out text report
open( my $out_fh, '>', $analysis_file )
  or die "[-] Cannot open text analysis file: $!";
print $out_fh "=== C++ PROJECT RELATIONSHIPS OVERVIEW ===\n\n";
print $out_fh "LEGEND:\n";
print $out_fh "  [f] Function   - Function definition\n";
print $out_fh "  [p] Prototype  - Function or method declaration\n";
print $out_fh "  [m] Member     - Class member variable or method\n";
print $out_fh "  [c] Class      - Class or struct definition\n";
print $out_fh "=" x 50 . "\n\n";

foreach my $file ( sort keys %definitions ) {
    print $out_fh "FILE: $file\n";

# Sort definitions by priority (f -> p -> m -> c) and alphabetically by name as secondary
    my @sorted_names = sort {
        my $p_a = $kind_priority{ $definitions{$file}{$a}{kind} } || 99;
        my $p_b = $kind_priority{ $definitions{$file}{$b}{kind} } || 99;
        $p_a <=> $p_b || $a cmp $b
    } keys %{ $definitions{$file} };

    foreach my $name (@sorted_names) {
        my $info = $definitions{$file}{$name};
        print $out_fh
          "  [$info->{kind}] $name $info->{signature} | Line: $info->{line}\n";

        if ( exists $calls{$name} ) {
            print $out_fh "    Called by:\n";
            my %seen;
            foreach my $call ( @{ $calls{$name} } ) {
                next if $seen{ $call->{callee} }++;
                print $out_fh
                  "      <- $call->{callee} | at $call->{file}:$call->{line}\n";
            }
        }
    }
    print $out_fh "\n" . ( "-" x 40 ) . "\n\n";
}
close($out_fh);

print "\n[SUCCESS] Pipeline completed successfully!\n";
print "--------------------------------------------------\n";
print "1. To open the CodeQuery graphical user interface, run:\n";
print "   codequery $db_path\n\n";
print "2. To check the text overview report, see:\n";
print "   $analysis_file\n";
print "--------------------------------------------------\n";
