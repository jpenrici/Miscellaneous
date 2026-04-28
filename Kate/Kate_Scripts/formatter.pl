#!/usr/bin/perl
# /home/scripts/formatter.pl
#
# Script for formatting files in Kate.
#
# Configuration:
# /home/user/.config/kate/externaltools/Formatter.ini
#
# [General]
# actionName=externaltool_Formatter
# arguments="%{Document:NativeFilePath}"
# category=Custom
# executable=/home/scripts/formatter.pl
# icon=code-function
# mimetypes=application/x-perl,application/x-shellscript,text/julia
# name=Formatter
# output=ReplaceCurrentDocument
# reload=true
# save=CurrentDocument
# trigger=None
#
# Configure the Alt+I key in Kate to call up the external Formatter tool.

use strict;
use warnings;
use utf8;
use File::Basename;

my %formatters = (
    'pl' => \&formatter_pl,    # Perl
    'jl' => \&formatter_jl,    # Julia
    'sh' => \&formatter_sh,    # Shell
);

sub show_help () {
    print "Use: perl formatter.pl <path/filename>\n";
    exit;
}

sub main {
    my ($path) = @_;

    show_help() if !$path || $path eq '--help';

    my ( undef, undef, $extension ) = fileparse( $path, qr/\.[^.]*/ );
    $extension =~ s/^\.//;
    my $ext = lc($extension);

    if ( exists $formatters{$ext} ) {
        return $formatters{$ext}->($path);
    }
    else {
        warn "Error: No formatter configured for the extension: $ext\n";
        return 1;
    }
}

sub formatter_pl {
    my ($path) = @_;
    return 1 unless -f "$path";
    system( '/usr/bin/perltidy', '-st', "$path" );
    return $? >> 8;
}

sub formatter_jl {
    my ($path) = @_;
    return 1 unless -f "$path";
    system( 'julia', '-e', "using JuliaFormatter; format_file(\"$path\")" );
    return $? >> 8;
}

sub formatter_sh {
    my ($path) = @_;
    return 1 unless -f "$path";
    system( '/usr/bin/shfmt', '-w', "$path" );
    return $? >> 8;
}

if ( !caller ) {
    exit( main(@ARGV) );
}

1;
