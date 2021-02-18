#!/usr/bin/perl
# $Id: switch.perl,v 1.5 2020-02-26 15:56:50-08 - - $

use strict;
use warnings;

use Math::Trig;

my %switch = (
   FOO=> sub {print "foo: @_\n"},
   BAR=> sub {print "bar: @_\n"},
   BAZ=> sub {print "baz:", (map {" [$_]"} @_), "\n"},
   ECHO=> sub {print "@_\n"},
);

$switch{FOO}->("foo", "bar");
$switch{BAR}->();
$switch{BAZ}->(qw(This is a test.));
$switch{ECHO}->("this", 33, acos(-1));

