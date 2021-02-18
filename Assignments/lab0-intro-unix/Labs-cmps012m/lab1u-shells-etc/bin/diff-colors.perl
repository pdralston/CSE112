#!/usr/bin/perl
# $Id: diff-colors.perl,v 1.1 2020-07-23 18:11:45-07 - - $

$0 =~ s|.*/||;
use strict;
use warnings;

my %hash;
my @files = qw (mkheader txt2html);

for my $file (@files) {
   open FILE, "<$file" or die "$0: $file: $!\n";
   while (defined (my $line = <FILE>)) {
      next unless $line =~ m/^\s*(\w+_\w+?)\s*=>\s*(.*?)\s*$/i;
      my ($color, $value) = ($1, $2);
      $hash{$color}{$file} = $value;
   }
   close FILE;
}

die "$0: wrong number of files]\n" unless @files == 2;
for my $color (sort keys %hash) {
   my @values;
   push @values, $hash{$color}{$_} for keys $hash{$color};
   next unless defined $values[0] && defined $values[1];
   if ($values[0] eq $values[1]) {
      $hash{$color}{'**BOTH**'} = $hash{$color}{$files[0]};
      delete $hash{$color}{$_} for @files;
   }else {
      print "ERROR: $color values differ: @values\n";
   }
}

for my $color (sort keys %hash) {
   for my $file (sort keys $hash{$color}) {
      printf "%-16s %-9s %s\n", $color, $file, $hash{$color}{$file};
   }
}

