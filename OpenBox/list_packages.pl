#!/usr/bin/perl
# ########################################################
# Simple script to help reinstall packages.
# Run when it is necessary to remember installed packages.
#
# Script:
#   1. list installed packages.
#   2. analyze dependencies.
#   3. generate and save recovery list.
#
# Use:
#   perl list_packages.pl <directory/filename.txt>
#   perl list_packages.pl --help
# ########################################################

use strict;
use utf8;
use warnings;

use File::Spec;
use File::Basename;
use POSIX qw(strftime);

sub main {

    print "Run list_packages.pl ...\n";

    my $arg = $_[0] // "";

    # Check for help or empty arg
    if ( !$arg || $arg eq '--help' ) {
        show_help();
        return 1;
    }

    # Check path
    my ( $name, $directories, $extension ) = fileparse( $arg, qr/\.[^.]*/ );

    if ( !-d $directories ) {
        warn "Error: Invalid path ('$directories').\n";
        show_help();
        return 1;
    }

    if ( $extension !~ /\.txt$/i ) {
        warn "Error: Invalid extension ('$extension').\n";
        show_help();
        return 1;
    }

    my $today         = strftime( "%Y-%m-%d", localtime );
    my $recovery_path = $directories . $name . "_" . $today . $extension;

    # 1. List of all Installed Packages
    my @package_list;
    my $installed_raw = list_packages_ref();

    # 2. Analyze dependencies
    my %dependency_map;
    my $counter = 1;
    foreach my $line (@$installed_raw) {
        chomp($line);
        if ( $line =~ /^install ok installed:(.+)$/ ) {
            my $package = $1;
            push( @package_list, $package );
            my $deps_raw = list_dependencies_ref($package);

            # Adds dependencies to the hash for faster searching.
            foreach my $dep ( split( ' ', $deps_raw ) ) {
                $dependency_map{$dep} = 1;
            }

            print("$counter : $package ...\n");
            $counter++;
        }
    }

    # 3. Generate and save Recovery List
    open( my $fh, '>', $recovery_path )
      or die "The file could not be created.: $!";

    print $fh "# $recovery_path\n";
    print $fh "apt install \\\n";

    # Filters packages that are NOT in the dependency list of others.
    my @filtered_packages = sort grep { !$dependency_map{$_} } @package_list;

    foreach my $pkg (@filtered_packages) {
        print $fh "\t$pkg \\\n";
    }

    print $fh "; # $recovery_path\n";
    close($fh);

    print "\nDone! List saved in: $recovery_path\n";

    return 0;
}

sub list_packages_ref {

    my $cmd    = "dpkg-query --show --showformat='\${Status}:\${Package}\\n'";
    my @result = qx{$cmd 2>/dev/null};

    if ( $? != 0 ) {
        warn
          "Warning: The command executed, but returned an error (status $?).";
        return [];
    }

    return \@result;
}

sub list_dependencies_ref {
    my $package = $_[0];
    my $cmd     = "dpkg-query -f='\${Depends}' -W $package";
    my $result  = qx{$cmd 2>/dev/null};

    if ( $? != 0 ) {
        warn
          "Warning: The command executed, but returned an error (status $?).";
        return "";
    }

    # Cleaning: removes versions enclosed in parentheses
    #           (e.g., (>= 1.0)) and punctuation.
    $result =~ s/\([^)]+\)//g;
    $result =~ s/[,|]//g;

    return \$result;
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
