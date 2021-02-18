#!/usr/bin/perl
# $Id: epsilon.perl,v 1.5 2020-09-18 10:20:37-07 - - $

# Find Perl epsilon.

use strict;
use warnings;

my $epsilon = 1;
do {
   $epsilon /= 10.0;
   printf "1.0 + %18.16f = %18.16f\n", $epsilon, 1.0 + $epsilon;
} while 1.0 + $epsilon != 1.0;

