#!/usr/bin/perl -w
# $Id: fibratio.perl,v 1.1 2020-11-18 19:39:25-08 - - $

# Print Fibonacci numbers showing convergence to Golden Ratio

use strict;
use warnings;

my $fib0 = 0;
my $fib1 = 1;

printf "F(%2d) = %10.0f\n", 0, $fib0;
my $prev_ratio = -1;
for (my $i = 1; $i < 50; ++$i) {
   my $ratio = $fib0 / $fib1;
   printf "F(%2d) = %10.0f ... F(%2d) / F(%2d) = %18.16f (%10.3e)\n",
          $i, $fib1, $i - 1, $i, $ratio, $prev_ratio - $ratio;;
   last if $prev_ratio == $ratio;
   $prev_ratio = $ratio;
   my $next = $fib0 + $fib1;
   $fib0 = $fib1;
   $fib1 = $next;
}

