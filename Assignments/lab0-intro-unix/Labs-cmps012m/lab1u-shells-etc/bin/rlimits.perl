#!/usr/bin/perl
# $Id: rlimits.perl,v 1.1 2019-10-31 14:23:02-07 - - $

my $status = 0;
END {exit $status};
$SIG{'__WARN__'} = sub {print STDERR "$0: @_"};
$SIG{'__DIE__'} = sub {warn @_; exit $status};


#
# Constants for system calls.
#
use constant {
   SYS_SETRLIMIT    =>        160,
   SYS_GETRLIMIT    =>         97,
   SYS_GETTIMEOFDAY =>         96,
   RLIM_INFINITY    => 0x7FFFFFFF,
   RLIMIT_CPU       =>          0, # cpu time in milliseconds
   RLIMIT_FSIZE     =>          1, # maximum file size
   RLIMIT_DATA      =>          2, # data size
   RLIMIT_STACK     =>          3, # stack size
   RLIMIT_CORE      =>          4, # core file size
   RLIMIT_NOFILE    =>          5, # file descriptors
   RLIMIT_VMEM      =>          6, # maximum mapped memory
   RLIM_NLIMITS     =>          7, # number of resource limits
};

#
# Gettimeofday(3c)
# int gettimeofday (struct timeval *tp, void *);
# long    tv_sec;    /* seconds since Jan. 1, 1970 */ 
# long    tv_usec;   /* and microseconds */
#
sub gettimeofday () {
   my $timeval = pack "LL", 0, 0;
   my $retval = syscall (SYS_GETTIMEOFDAY, $timeval, 0);
   die "gettimeofday" unless $retval == 0;
   my ($tv_sec, $tv_usec) = unpack "LL", $timeval;
   return $tv_sec + $tv_usec / 1e6;
}

sub getrlimit ($) {
   my ($resource) = @_;
   my $rlimit = pack "LL", 0, 0;
   my $retval = syscall (SYS_GETRLIMIT, $resource, $rlimit);
   die "getrlimit ($resource)" unless $retval == 0;
   return unpack "LL", $rlimit;
}

sub setrlimit ($$$) {
   my ($resource, $rlim_cur, $rlim_max) = @_;
   my $rlimit = pack "LL", $rlim_cur, $rlim_max;
   my $retval = syscall (SYS_SETRLIMIT, $resource, $rlimit);
   die "setrlimit ($resource, $rlim_cur, $rlim_max)"
       unless $retval == 0;
}

print "gettimeofday  = ", gettimeofday (), "\n";

print "RLIMIT_CPU    = ", getrlimit (RLIMIT_CPU   ), "\n";
print "RLIMIT_FSIZE  = ", getrlimit (RLIMIT_FSIZE ), "\n";
print "RLIMIT_DATA   = ", getrlimit (RLIMIT_DATA  ), "\n";
print "RLIMIT_STACK  = ", getrlimit (RLIMIT_STACK ), "\n";
print "RLIMIT_CORE   = ", getrlimit (RLIMIT_CORE  ), "\n";
print "RLIMIT_NOFILE = ", getrlimit (RLIMIT_NOFILE), "\n";
print "RLIMIT_VMEM   = ", getrlimit (RLIMIT_VMEM  ), "\n";
print "RLIM_NLIMITS  = ", getrlimit (RLIM_NLIMITS ), "\n";

