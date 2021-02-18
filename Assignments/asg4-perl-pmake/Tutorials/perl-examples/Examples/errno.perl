#!/usr/bin/perl -w
use strict;
use warnings;
my $RCSID = '$Id: errno.perl,v 1.2 2020-11-18 17:11:48-08 - - $';
#
# NAME
#    errno.perl - print out system error codes
#
# SYNOPSIS
#    errno.perl [errno...]
#
# DESCRIPTION
#    Prints out the system error codes given on the command line.
#    Prints all of them if none.

if (@ARGV) {
   for my $errno (@ARGV) {
      if ($errno !~ m/^\d+$/) {
         print STDERR "$0: $errno: not a number\n";
      }else {
         $! = $errno;
         print "error($errno) = $!\n";
      };
   };
}else {
   for (my $errno = 0; $errno < 128; ++$errno) {
      $! = $errno;
      my $strerror = "$!";
      next if $strerror =~ m/Uninown error/;
      print "error($errno) = $!\n";
   };
};
