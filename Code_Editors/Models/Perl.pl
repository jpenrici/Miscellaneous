#!/usr/bin/perl
# main.pl

use strict;
use warnings;
use utf8;
use feature 'say'; # print + newline

sub main {

    my @args = @_; # capture command line arguments
    if (@args) {
        say "Arguments received: ". join(", ", @args);
    }

    return 0;
}

if ( !caller ){
    exit(main(@ARGV));
}

1; 