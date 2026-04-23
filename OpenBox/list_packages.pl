#!/usr/bin/perl
#
# Simple script to help reinstall packages.
# Run when it is necessary to remember installed packages.
#
# Script:
#   1. list installed packages.
#   2. analyze dependencies.
#   3. generate and save recovery list.

# Adapting for Perl!!! ...

use strict;
use utf8;
use warnings;

use File::Spec;
use File::Basename;
use POSIX qw(strftime);

sub main {

    my @args   = @_;
    my $script = "list_packages.pl";

    # Check for help or empty args
    if ( !@args || $args[0] eq '--help' ) {
        warn "Error: No argument.\n";
        show_help();
        return 1;
    }

    # Check path
    my ( $filename, $directories ) = fileparse( $args[0] );

    if ( !-d $directories ) {
        warn "Error: Invalid path.\n";
        show_help();
        return 1;
    }

    if ( $filename !~ /\.txt$/i ) {
        warn "Error: Invalid extension.\n";
        show_help();
        return 1;
    }

    # Run
    print "Run $script ...\n";

    my $today = strftime "%Y-%m-%d", localtime();

    my $packageList    = "/tmp/packageList";
    my $dependencyList = "/tmp/dependencyList";
    my $recoveryList   = "recoveryList-$today";

    # List of all Installed Packages
    my $packages = list_packages_ref();

    # Test
    foreach my $p (@$packages) {
        print "$p\n";
    }

    return 0;
}

sub list_packages_ref {
    my $cmd    = "dpkg-query --show --showformat='\${Status;7}:\${Package} '";
    my $result = qx{$cmd 2>/dev/null};

    if ( $? != 0 ) {
        warn
          "Warning: The command executed, but returned an error (status $?).";
        return [];
    }

    # if the result is null or contains only spaces, it returns an empty array.
    return [] unless $result && $result =~ /\S/;

    # separate at any sequence of spaces and line breaks.
    my @list = split( /\s+/, $result );

    return \@list;
}

sub show_help() {
    print "Use:\n";
    print "  perl list_packages.pl <directory/filename.txt>\n";
    print "  perl list_packages.pl --help\n";
}

if ( !caller ) {
    exit( main(@ARGV) );
}

1;
