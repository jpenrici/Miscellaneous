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
#   sudo perl scan.pl [--quick] [--update] [--dir /path] [--estimate-only]
#
#   --quick          Scan only the most critical directories
#   --update         Run freshclam before scanning to update virus definitions
#   --dir /path      Scan a custom directory instead of the default list
#   --estimate-only  Count files and show time estimate without scanning
#
# Time estimation strategy:
#   1. Count scannable files with `find` (fast, < a few seconds)
#   2. Benchmark clamscan on a small sample of real files (~50) to measure
#      the actual scan rate (files/sec) on this machine
#   3. Extrapolate: estimated_seconds = file_count / rate
#   This is more accurate than a fixed constant because it reflects the
#   current machine load, disk speed, and ClamAV definition database size.
#--------------------------------------------------

use strict;
use warnings;
use utf8;
use feature 'say';
use POSIX        qw(strftime floor);
use Getopt::Long qw(GetOptions);
use List::Util   qw(min);

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

# Number of files used for the benchmark sample
my $BENCHMARK_SAMPLE = 50;

# Fallback rate (files/sec) when benchmark produces no usable data.
# Conservative estimate for a typical SSD-based Debian system.
my $FALLBACK_RATE = 2_000;

# clamscan flags for the real scan
my @CLAMSCAN_OPTS = qw(
    --recursive
    --infected
    --no-summary
    --stdout
    --suppress-ok-results
);

#--------------------------------------------------
# Helpers
#--------------------------------------------------

sub timestamp { strftime('%Y-%m-%d %H:%M:%S', localtime) }

sub format_duration {
    my ($secs) = @_;
    return '< 1s' if $secs < 1;
    my $h = int($secs / 3600);
    my $m = int(($secs % 3600) / 60);
    my $s = $secs % 60;
    return $h ? sprintf('%dh %02dm %02ds', $h, $m, $s)
         : $m ? sprintf('%dm %02ds', $m, $s)
         :       sprintf('%ds', $s);
}

sub format_count {
    # Add thousands separator for readability
    my ($n) = @_;
    $n = reverse sprintf('%d', $n);
    $n =~ s/(\d{3})(?=\d)/$1,/g;
    return scalar reverse $n;
}

sub print_banner {
    my ($dirs_ref) = @_;
    say '=' x 60;
    say '  ClamAV Linux Scanner';
    say '  Started : ' . timestamp();
    say '  Dirs    : ' . scalar(@$dirs_ref) . ' target(s)';
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
    my $rc = system('freshclam', '--quiet');
    if ( $rc != 0 ) {
        warn "[WARN] freshclam exited with code $rc. Continuing with existing definitions.\n";
    } else {
        say '[INFO] Definitions updated successfully.';
    }
}

#--------------------------------------------------
# Pre-scan estimation
#--------------------------------------------------

# Count all regular files under the given directories using `find`.
# Returns (file_count, list_of_sample_files).
sub count_files {
    my ($dirs_ref) = @_;

    my @existing = grep { -d $_ } @$dirs_ref;
    return (0, []) unless @existing;

    say '[ESTIMATE] Counting files (this takes a few seconds)...';

    # Single `find` call across all dirs; -xdev stays on the same filesystem
    # to avoid scanning /proc, /sys, network mounts, etc.
    my @cmd = ('find', @existing, '-xdev', '-type', 'f');

    open(my $pipe, '-|', @cmd)
        or die "[ERROR] Cannot run find: $!\n";

    my $count   = 0;
    my @samples;

    while ( my $line = <$pipe> ) {
        chomp $line;
        $count++;
        # Reservoir sampling — keep up to $BENCHMARK_SAMPLE files
        if ( $count <= $BENCHMARK_SAMPLE ) {
            push @samples, $line;
        } elsif ( rand($count) < $BENCHMARK_SAMPLE ) {
            $samples[ int(rand($BENCHMARK_SAMPLE)) ] = $line;
        }
    }

    close($pipe);
    return ($count, \@samples);
}

# Benchmark clamscan on a small sample of real files.
# Returns the measured scan rate in files/second.
sub benchmark_scan_rate {
    my ($clamscan, $samples_ref) = @_;

    return $FALLBACK_RATE unless @$samples_ref;

    say '[ESTIMATE] Benchmarking scan speed on ' . scalar(@$samples_ref) . ' sample files...';

    # Scan just the sample files (no recursion needed — they're individual paths)
    my @cmd = (
        $clamscan,
        '--no-summary',
        '--stdout',
        '--suppress-ok-results',
        @$samples_ref,
    );

    my $t0 = time;
    open(my $pipe, '-|', @cmd)
        or return $FALLBACK_RATE;

    my $scanned = 0;
    while ( <$pipe> ) { $scanned++ }
    close($pipe);

    my $elapsed = time - $t0;

    # Avoid division by zero or absurdly fast benchmarks (< 0.1s)
    return $FALLBACK_RATE if $elapsed < 1;

    my $rate = int( scalar(@$samples_ref) / $elapsed );
    return $rate > 0 ? $rate : $FALLBACK_RATE;
}

# Print the estimation block.
sub print_estimate {
    my ($file_count, $rate, $dirs_ref) = @_;

    my $existing_count = scalar grep { -d $_ } @$dirs_ref;
    my $estimated_secs = $rate > 0 ? int($file_count / $rate) : 0;

    # Add 15% overhead for ClamAV startup, I/O bursts, large files
    $estimated_secs = int($estimated_secs * 1.15);

    say '';
    say '=' x 60;
    say '  PRE-SCAN ESTIMATE';
    say '=' x 60;
    say '  Directories found   : ' . $existing_count;
    say '  Files to scan       : ' . format_count($file_count);
    say '  Measured scan rate  : ' . format_count($rate) . ' files/sec';
    say '  Estimated duration  : ' . format_duration($estimated_secs);
    say '-' x 60;
    say '  Note: actual time varies with file sizes, disk cache,';
    say '        and system load. Estimate includes 15% overhead.';
    say '=' x 60;
    say '';

    return $estimated_secs;
}

#--------------------------------------------------
# Scanning
#--------------------------------------------------

sub run_scan {
    my ($clamscan, $dirs_ref) = @_;

    my @existing = grep { -d $_ } @$dirs_ref;
    die "[ERROR] None of the target directories exist on this system.\n"
        unless @existing;

    my @infected;
    my @errors;
    my $start = time;

    say '[INFO] Scan in progress...';

    my @cmd = ($clamscan, @CLAMSCAN_OPTS, @existing);

    open(my $pipe, '-|', @cmd)
        or die "[ERROR] Failed to launch clamscan: $!\n";

    while ( my $line = <$pipe> ) {
        chomp $line;

        if ( $line =~ /^(.+):\s+(.+)\s+FOUND$/ ) {
            push @infected, { file => $1, signature => $2 };
            say "[THREAT] $line";
        }
        elsif ( $line =~ /^(.+):\s+(.+)\s+ERROR$/ ) {
            push @errors, { file => $1, reason => $2 };
        }
    }

    close($pipe);

    my $exit_code = $? >> 8;
    my $elapsed   = time - $start;

    return (\@infected, \@errors, $elapsed, $exit_code);
}

#--------------------------------------------------
# Human-readable summary
#--------------------------------------------------

sub print_summary {
    my ($infected_ref, $errors_ref, $elapsed, $estimated_secs, $dirs_ref, $exit_code) = @_;

    my $threat_count = scalar @$infected_ref;
    my $error_count  = scalar @$errors_ref;

    # Accuracy of the estimate (only meaningful if we had one)
    my $accuracy_note = '';
    if ( $estimated_secs > 0 ) {
        my $diff_pct = int( abs($elapsed - $estimated_secs) / $estimated_secs * 100 );
        $accuracy_note = "  Estimate accuracy   : within ${diff_pct}% of actual";
    }

    say '';
    say '=' x 60;
    say '  SCAN SUMMARY';
    say '  Finished: ' . timestamp();
    say '=' x 60;
    say '  Directories scanned : ' . scalar(grep { -d $_ } @$dirs_ref);
    say '  Duration (actual)   : ' . format_duration($elapsed);
    say $accuracy_note if $accuracy_note;
    say '  Threats found       : ' . $threat_count;
    say '  Errors / skipped    : ' . $error_count;
    say '-' x 60;

    if ( $threat_count == 0 ) {
        say '  [OK] No threats detected. System appears clean.';
    } else {
        say "  [!] $threat_count INFECTED FILE(S) DETECTED:";
        say '';
        for my $hit ( @$infected_ref ) {
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

    if ( $exit_code == 2 ) {
        say '[WARN] clamscan reported an internal error (exit code 2).';
        say '       Try: sudo freshclam';
    }
}

#--------------------------------------------------
# Entry point
#--------------------------------------------------

sub main {
    my $opt_quick         = 0;
    my $opt_update        = 0;
    my $opt_dir           = '';
    my $opt_estimate_only = 0;

    GetOptions(
        'quick'          => \$opt_quick,
        'update'         => \$opt_update,
        'dir=s'          => \$opt_dir,
        'estimate-only'  => \$opt_estimate_only,
    ) or die "Usage: sudo perl scan.pl [--quick] [--update] [--dir /path] [--estimate-only]\n";

    my $clamscan = check_prerequisites();

    update_definitions() if $opt_update;

    my @dirs =
        $opt_dir   ? ($opt_dir)  :
        $opt_quick ? @QUICK_DIRS :
                     @FULL_DIRS;

    print_banner(\@dirs);

    # --- Pre-scan estimation ---
    my ($file_count, $samples) = count_files(\@dirs);
    my $rate                   = benchmark_scan_rate($clamscan, $samples);
    my $estimated_secs         = print_estimate($file_count, $rate, \@dirs);

    if ( $opt_estimate_only ) {
        say '[INFO] --estimate-only: skipping actual scan.';
        return 0;
    }

    # --- Real scan ---
    my ($infected, $errors, $elapsed, $exit_code) =
        run_scan($clamscan, \@dirs);

    print_summary($infected, $errors, $elapsed, $estimated_secs, \@dirs, $exit_code);

    return $exit_code == 2 ? 2
         : scalar(@$infected) ? 1
         : 0;
}

if ( !caller ) {
    exit( main() );
}

1;
