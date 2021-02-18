#!/usr/bin/perl
use strict;
use warnings;
my $RCSID = '$Id: ncat.perl,v 1.2 2020-11-18 17:21:47-08 - - $';

$0 =~ s|.*/||;
my $exit_status = 0;
END { exit $exit_status; }
sub note (@) { print STDERR "$0: @_"; };
$SIG{'__WARN__'} = sub { note @_; $exit_status = 1; };
$SIG{'__DIE__'} = sub { warn @_; exit; };


while (<>) {
   next if m/^\s*#/;
   print "$ARGV:$.:$_";
}continue {
   close ARGV if eof;
};

