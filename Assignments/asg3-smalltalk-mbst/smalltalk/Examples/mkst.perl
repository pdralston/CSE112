#!/usr/bin/perl
# $Id: mkst.perl,v 1.11 2020-09-01 17:00:13-07 - - $
# Run smalltalk and capture the output.

$0 =~ s|.*/||;
use strict;
use warnings;

sub print_both($@) {
   my ($file, @lines) = @_;
   print @lines;
   print $file @lines;
}

sub status($) {
   my ($wait) = @_;
   my $status = "status " . ($wait >> 8);
   $status .= " (core)" if $wait & 0x80;
   my $signal = $wait & 0x7F;
   $status .= " signal $signal" if $signal;
   return $status;
}

for my $prog (@ARGV) {
   system "cid -is $prog";

   my $lis = "$prog.lis";

   open my $progfile, "<$prog" or die "$0: $prog: $!";
   open my $lisfile, ">$lis" or die "$0: $prog: $!";

   while (<$progfile>) {
      next unless m/"TEST:\s*(.*)"/;
      my $cmd = $1;
      print_both $lisfile, "$0: $cmd\n";
      print_both $lisfile, qx($cmd);
      print_both $lisfile, "Exit ", status $?, "\n";
   }

#  system "txt2html $prog";
#  system "txt2html $lis";

#  system "mkpspdf $prog.ps $prog $lis";

}
