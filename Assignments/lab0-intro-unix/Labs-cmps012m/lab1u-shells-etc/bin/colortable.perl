#!/usr/bin/perl
# $Id: colortable.perl,v 1.1 2020-07-19 12:42:21-07 - - $
#
# Print a color table of 8bg * 8fg * 2 states (regular/bold)

$line = "-" x 69;
print <<__END__;

Table for 16-color terminal escape sequences.
Replace ESC with \\033 in bash.

Background | Foreground colors
$line
__END__

for $bg (40..47) {
   for $bold (0..1) {
      print "\033[0m ESC[${bg}m   | ";
      for $fg (30..37) {
         if ($bold) {print "\033[${bg}m\033[1;${fg}m [1;${fg}m"}
               else {print "\033[${bg}m\033[${fg}m [${fg}m  "}
      }
      print "\033[0m\n";
   }
   print "$line\n";
}
print "\n\n";
