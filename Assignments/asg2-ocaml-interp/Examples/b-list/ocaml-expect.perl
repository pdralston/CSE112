#!/usr/bin/perl
# $Id: ocaml-expect.perl,v 1.2 2021-01-26 13:02:01-08 - - $

# Expect script which runs ocaml interactively with data
# from STDIN, showing interactive transacript.

$0 =~ s|.*/||;
use strict;
use warnings;

my $expect = "| expect 2>&1";
open EXPECT, $expect or die "$0: open $expect: $!\n";
print EXPECT "spawn ocaml\n";

my $input = "";
while (my $line = <>) {
   next if $line =~ m/^#!/;
   $line =~ s/[\[\]\$"]/\\$&/g;
   $input .= $line;
   next unless $input =~ m/;;/;
   print EXPECT "expect \"# \"\n";
   print EXPECT "send -- \"$input\\n\"\n";
}

close EXPECT;
print "\n";

