#!/usr/bin/perl -w
use strict;
use warnings;
my $RCSID = '$Id: argv.perl,v 1.2 2020-11-18 16:56:42-08 - - $';
#
# NAME
#    $0 - print out command line arguments and other things
#
# SYNOPSIS
#    $0 [args]
#
# DESCRIPTION
#    Prints out command line arguments in debug mode, along
#    with the RCSID, date and time.
#

use POSIX qw(strftime);

print "\$0 = $0\n";
$0 =~ s|.*/||;
print "\$0 = $0\n";
print "\$RCSID = $RCSID\n";

printf "\$^T = $^T = %s\n",
       strftime "%Y-%m-%d %a %H:%M:%S %Z", localtime $^T;
map {print "\$ARGV[$_] = $ARGV[$_]\n"} 0..$#ARGV;

