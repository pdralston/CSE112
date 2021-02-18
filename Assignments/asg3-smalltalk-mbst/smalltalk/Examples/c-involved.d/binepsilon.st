#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: binepsilon.st,v 1.3 2021-02-11 16:24:40-08 - - $"

nl := Character nl.

epsilon := [:asFloat|
   |one div epsilon|
   one := 1.0 perform: asFloat.
   div := 2.0 perform: asFloat.
   epsilon := one.
   repeat := [
      |sum|
      epsilon := (epsilon / div) perform: asFloat.
      sum := (one + epsilon) perform: asFloat.
      sum > one
   ].
   repeat whileTrue: [].
   epsilon
].

#( #asFloatE #asFloatD) do: [:float|
   stdout << float << ' epsilon = ' << (epsilon value: float)
          << Character nl.
].

