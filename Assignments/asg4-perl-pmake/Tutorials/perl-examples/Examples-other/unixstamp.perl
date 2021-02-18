#!/usr/bin/perl
# $Id: unixstamp.perl,v 340.2 2020-11-18 15:50:27-08 - - $
use POSIX qw( strftime );
push @ARGV, 1<<30 unless @ARGV;
for $stamp( @ARGV ){
   $stamp = eval( $stamp ) + 0;
   @stamp = localtime( $stamp );
   $datime = strftime( "%Y-%m-%d (%a) %H:%M:%S %Z", @stamp );
   printf "0x%08X == %12d == %s\n", $stamp, $stamp, $datime;
};
