#!/usr/bin/perl
# compile_and_run.pl
#
# Checks if the directory contains a CMakeLists.txt, compiles it,
# and optionally runs the generated executable.
#
# Use:
#     perl compile_and_run.pl --dir=<path> [--exe=<name>] [--args="<arg1 arg2 ...>"]
#
# Options:
#     --dir=<path>          Directory containing CMakeLists.txt (required)
#     --exe=<name>          Executable name to run after build (optional)
#     --args="<arguments>"  Arguments passed to the executable, space-separated (optional)
#
# Examples:
#     perl compile_and_run.pl --dir=./myproject
#     perl compile_and_run.pl --dir=./myproject --exe=myapp
#     perl compile_and_run.pl --exe=myapp --dir=./myproject --args="foo bar baz"

use strict;
use warnings;
use utf8;

use File::Find;
use File::Spec;

sub main {

    my %opt = parse_args(@_);

    if ( $opt{help} ) {
        show_help();
        exit 0;
    }

    if ( !$opt{dir} ) {
        show_message("Error: --dir is required.\n");
        show_help();
        exit 1;
    }

    my $directory = File::Spec->catdir( $opt{dir}, '' );
    if ( !-d $directory ) {
        show_message("Error: Directory not found ('$directory')!\n");
        exit 1;
    }

    my $cmake_file = File::Spec->catfile( $directory, "CMakeLists.txt" );
    if ( !-f $cmake_file ) {
        show_message("Error: 'CMakeLists.txt' not found in '$directory'!\n");
        exit 1;
    }

    my $build_dir = File::Spec->catdir( $directory, "build" );
    if ( !-d $build_dir ) {
        system( "cmake", "-S", $directory, "-B", $build_dir ) == 0
          or die show_message("Error: CMake configuration failed!\n");
    }

    system( "cmake", "--build", $build_dir ) == 0
      or die show_message("Error: CMake build failed!\n");

    if ( !$opt{exe} ) {
        show_message("Build complete. No --exe provided, skipping run.\n");
        return 0;
    }

    my $executable_path;
    File::Find::find(
        sub {
            $executable_path = $File::Find::name
              if !$executable_path && $_ eq $opt{exe} && -f $_ && -x $_;
        },
        $build_dir
    );

    if ( !$executable_path ) {
        show_message("Error: Executable '$opt{exe}' not found in '$build_dir'!\n");
        exit 1;
    }

    my @run_args = $opt{args} ? split( ' ', $opt{args} ) : ();

    show_message( "Running: $executable_path" . ( @run_args ? " @run_args" : "" ) . "\n" );
    my $exit_code = system( $executable_path, @run_args );
    return $exit_code >> 8;
}

sub parse_args {
    my %opt = ( help => 0 );

    for my $arg (@_) {
        if    ( $arg =~ /^--dir=(.+)$/ )           { $opt{dir}  = $1 }
        elsif ( $arg =~ /^--exe=(.+)$/ )           { $opt{exe}  = $1 }
        elsif ( $arg =~ /^--args=(.*)$/ )          { $opt{args} = $1 }
        elsif ( $arg eq "--help" || $arg eq "-h" ) { $opt{help} = 1 }
        else {
            show_message("Warning: Unknown argument '$arg' ignored.\n");
        }
    }

    return %opt;
}

sub show_help {
    printf("Use:\n");
    printf("  perl compile_and_run.pl --dir=<path> [--exe=<name>] [--args=\"<arg1 arg2 ...>\"]\n\n");
    printf("Options:\n");
    printf("  --dir=<path>            Directory containing CMakeLists.txt (required)\n");
    printf("  --exe=<name>            Executable name to run after build (optional)\n");
    printf("  --args=\"<arguments>\"  Arguments passed to the executable (optional)\n");
}

sub show_message {
    my ($message) = @_;
    printf( "[Compile and Run] %s", $message ) if $message;
}

if ( !caller ) {
    exit( main(@ARGV) );
}

1;
