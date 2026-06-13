#!/usr/bin/perl
#--------------------------------------------------
# scan.pl
#
# Purpose: Use ClamAV to scan critical Debian/Linux directories
#          and present a human-readable summary of results.
#
# Requirements:
#   - ClamAV installed (apt install clamav clamav-daemon)
#   - clamscan available in PATH
#   - Run as root (or with sufficient permissions) for full access
#
# Usage:
#   sudo perl scan.pl [--quick] [--update] [--dir /path] [--dry-run]
#
#   --quick      Scan only the most critical directories
#   --update     Run freshclam before scanning to update virus definitions
#   --dir /path  Scan a custom directory instead of the default list
#   --dry-run    Count files per directory without scanning
#
# Progress strategy:
#   Directories are scanned one at a time. For each directory:
#     1. Count files with `find` so the progress line shows a denominator
#     2. Launch clamscan with --verbose to receive one output line per file
#     3. Rewrite a single terminal line (\r) showing:
#            [N/T] /dir   X,XXX / Y,YYY files   Z threats
#     4. On completion print a summary line for that directory and move on
#   A global summary is printed at the end.
#--------------------------------------------------

use strict;
use warnings;
use utf8;
use feature 'say';
use POSIX        qw(strftime);
use Getopt::Long qw(GetOptions);

binmode STDOUT, ':encoding(UTF-8)';

#--------------------------------------------------
# Configuration
#--------------------------------------------------

# Directories to scan in full mode (ordered by risk relevance)
my @FULL_DIRS = qw(
  /bin
  /sbin
  /usr/bin
  /usr/sbin
  /usr/local/bin
  /usr/local/sbin
  /lib
  /lib64
  /usr/lib
  /tmp
  /var/tmp
  /dev/shm
  /home
  /root
  /etc
  /boot
  /opt
  /srv
  /var/www
  /var/mail
  /var/spool
);

# Subset used with --quick
my @QUICK_DIRS = qw(
  /tmp
  /var/tmp
  /dev/shm
  /home
  /root
  /var/www
);

# clamscan flags used during the real scan.
# --verbose makes clamscan emit one line per file scanned, which we use
# to drive the live progress counter.
# --infected ensures infected files are always printed regardless of --verbose.
my @CLAMSCAN_OPTS = qw(
  --recursive
  --verbose
  --infected
  --no-summary
  --stdout
);

#--------------------------------------------------
# Helpers
#--------------------------------------------------

sub usage {
    my $msg =
"Usage: sudo perl scan.pl [--quick] [--update] [--dir /path] [--dry-run]\n\n"
      . "  --quick      Scan only the most critical directories\n"
      . "  --update     Run freshclam before scanning to update virus definitions\n"
      . "  --dir /path  Scan a custom directory instead of the default list\n"
      . "  --dry-run    Count files per directory without scanning\n";
    return $msg;
}

sub timestamp { strftime( '%Y-%m-%d %H:%M:%S', localtime ) }

sub format_duration {
    my ($secs) = @_;
    return '< 1s' if $secs < 1;
    my $h = int( $secs / 3600 );
    my $m = int( ( $secs % 3600 ) / 60 );
    my $s = $secs % 60;
    return
        $h ? sprintf( '%dh %02dm %02ds', $h, $m, $s )
      : $m ? sprintf( '%dm %02ds', $m, $s )
      :      sprintf( '%ds', $s );
}

sub format_count {

    # Insert thousands separators for readability (e.g. 12345 -> 12,345)
    my ($n) = @_;
    $n = reverse sprintf( '%d', $n );
    $n =~ s/(\d{3})(?=\d)/$1,/g;
    return scalar reverse $n;
}

sub print_banner {
    my ($dirs_ref) = @_;
    say '=' x 60;
    say '  ClamAV Linux Scanner';
    say '  Started  : ' . timestamp();
    say '  Dirs     : ' . scalar(@$dirs_ref) . ' target(s)';
    say "    $_" for @$dirs_ref;
    say '=' x 60;
}

sub check_prerequisites {
    my $clamscan = qx(which clamscan 2>/dev/null);
    chomp $clamscan;
    die "[ERROR] clamscan not found. Install with: sudo apt install clamav\n"
      unless $clamscan;

    warn "[WARN] Not running as root. Some directories may be unreadable.\n"
      if $> != 0;

    return $clamscan;
}

sub update_definitions {
    say '[INFO] Updating ClamAV virus definitions (freshclam)...';
    my $rc = system( 'freshclam', '--quiet' );
    if ( $rc != 0 ) {
        warn
"[WARN] freshclam exited with code $rc. Continuing with existing definitions.\n";
    }
    else {
        say '[INFO] Definitions updated successfully.';
    }
}

#--------------------------------------------------
# File counting
#--------------------------------------------------

# Count regular files under a single directory using `find`.
# -xdev keeps find on the same filesystem, avoiding /proc, /sys,
# network mounts, and other virtual filesystems.
# Returns the file count (0 if the directory does not exist).
sub count_files_in_dir {
    my ($dir) = @_;
    return 0 unless -d $dir;

    open( my $pipe, '-|', 'find', $dir, '-xdev', '-type', 'f' )
      or return 0;

    my $count = 0;
    $count++ while <$pipe>;
    close($pipe);

    return $count;
}

#--------------------------------------------------
# Scanning
#--------------------------------------------------

# Scan a single directory and display a live progress line.
#
# Parameters:
#   $clamscan   - path to the clamscan binary
#   $dir        - directory to scan
#   $file_count - pre-counted number of files (used as denominator)
#   $label      - progress prefix, e.g. "[2/6]"
#
# Returns:
#   ( \@infected, \@errors, $elapsed )
#
# Progress display:
#   Uses \r (carriage return) to rewrite the same terminal line while
#   scanning. Each line from clamscan --verbose that matches
#   "Scanning /path/to/file" increments the counter.
#   Threats and errors are printed above the progress line as they appear.
sub scan_directory {
    my ( $clamscan, $dir, $file_count, $label ) = @_;

    my @infected;
    my @errors;
    my $scanned = 0;
    my $threats = 0;
    my $start   = time;
    my $total   = format_count($file_count);

    my @cmd = ( $clamscan, @CLAMSCAN_OPTS, $dir );

    open( my $pipe, '-|', @cmd )
      or die "[ERROR] Failed to launch clamscan on $dir: $!\n";

    while ( my $line = <$pipe> ) {
        chomp $line;

        if ( $line =~ /^(.+):\s+(.+)\s+FOUND$/ ) {

            # Print threat above the progress line
            print "\n";
            say "[THREAT] $line";
            push @infected, { file => $1, signature => $2 };
            $threats++;
        }
        elsif ( $line =~ /^(.+):\s+(.+)\s+ERROR$/ ) {
            push @errors, { file => $1, reason => $2 };
        }
        elsif ( $line =~ /^Scanning / ) {

            # clamscan --verbose emits "Scanning /path" for every file
            $scanned++;
            my $progress =
              sprintf( "\r  %s  %-22s  %s / %s files  |  %d threat(s)",
                $label, $dir, format_count($scanned), $total, $threats );
            print $progress;
        }
    }

    close($pipe);

    my $elapsed = time - $start;

    # End the progress line and print a per-directory summary
    printf( "\r  %s  %-22s  %s files  |  %d threat(s)  |  %s\n",
        $label, $dir, format_count($scanned), $threats,
        format_duration($elapsed) );

    return ( \@infected, \@errors, $elapsed );
}

#--------------------------------------------------
# Human-readable summary
#--------------------------------------------------

sub print_summary {
    my ( $infected_ref, $errors_ref, $elapsed, $dirs_ref, $exit_code ) = @_;

    my $threat_count = scalar @$infected_ref;
    my $error_count  = scalar @$errors_ref;

    say '';
    say '=' x 60;
    say '  SCAN SUMMARY';
    say '  Finished : ' . timestamp();
    say '=' x 60;
    say '  Directories scanned : ' . scalar( grep { -d $_ } @$dirs_ref );
    say '  Total duration      : ' . format_duration($elapsed);
    say '  Threats found       : ' . $threat_count;
    say '  Errors / skipped    : ' . $error_count;
    say '-' x 60;

    if ( $threat_count == 0 ) {
        say '  [OK] No threats detected. System appears clean.';
    }
    else {
        say "  [!] $threat_count INFECTED FILE(S) DETECTED:";
        say '';
        for my $hit (@$infected_ref) {
            say "  File      : $hit->{file}";
            say "  Signature : $hit->{signature}";
            say "  Action    : Quarantine or delete immediately.";
            say '  ' . '-' x 56;
        }
    }

    if ( $error_count > 0 ) {
        say '';
        say "  [$error_count] file(s) could not be scanned:";
        say "    $_->{file}: $_->{reason}" for @$errors_ref;
    }

    say '=' x 60;

    if ( $exit_code != 0 && $exit_code != 1 ) {
        say '[WARN] clamscan reported an internal error (exit code '
          . $exit_code . ').';
        say '       Try: sudo freshclam';
    }
}

#--------------------------------------------------
# Entry point
#--------------------------------------------------

sub main {
    die usage() unless @ARGV;

    my $opt_quick   = 0;
    my $opt_update  = 0;
    my $opt_dir     = '';
    my $opt_dry_run = 0;

    GetOptions(
        'quick'   => \$opt_quick,
        'update'  => \$opt_update,
        'dir=s'   => \$opt_dir,
        'dry-run' => \$opt_dry_run,
    ) or die usage();

    my $clamscan = check_prerequisites();

    update_definitions() if $opt_update;

    my @dirs =
        $opt_dir   ? ($opt_dir)
      : $opt_quick ? @QUICK_DIRS
      :              @FULL_DIRS;

    # Keep only directories that actually exist on this system
    my @existing = grep { -d $_ } @dirs;
    die "[ERROR] None of the target directories exist on this system.\n"
      unless @existing;

    print_banner( \@existing );

    # --- Count files per directory ---
    say '[INFO] Counting files per directory...';
    my %file_counts;
    my $total_files = 0;
    for my $dir (@existing) {
        my $n = count_files_in_dir($dir);
        $file_counts{$dir} = $n;
        $total_files += $n;
        printf( "  %-30s  %s files\n", $dir, format_count($n) );
    }
    say '-' x 60;
    say '  Total : ' . format_count($total_files) . ' files';
    say '=' x 60;
    say '';

    if ($opt_dry_run) {
        say '[INFO] --dry-run: skipping actual scan.';
        return 0;
    }

    # --- Scan each directory in turn ---
    my @all_infected;
    my @all_errors;
    my $grand_start = time;
    my $total_dirs  = scalar @existing;
    my $exit_code   = 0;

    for my $i ( 0 .. $#existing ) {
        my $dir   = $existing[$i];
        my $label = sprintf( '[%d/%d]', $i + 1, $total_dirs );

        my ( $infected, $errors, $elapsed ) =
          scan_directory( $clamscan, $dir, $file_counts{$dir}, $label );

        push @all_infected, @$infected;
        push @all_errors,   @$errors;
    }

    my $grand_elapsed = time - $grand_start;

    # clamscan exit code: 0 = clean, 1 = virus found, 2 = error
    $exit_code = @all_infected ? 1 : 0;

    print_summary(
        \@all_infected, \@all_errors, $grand_elapsed,
        \@existing,     $exit_code
    );

    return $exit_code;
}

if ( !caller ) {
    exit( main() );
}

1;
