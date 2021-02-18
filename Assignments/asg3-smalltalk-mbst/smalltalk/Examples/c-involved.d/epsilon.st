#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: epsilon.st,v 1.4 2021-02-10 19:22:11-08 - - $"

nl := Character nl.

epsilon := [:asFloat|
   |one div epsilon|
   one := 1.0 perform: asFloat.
   div := 10.0 perform: asFloat.
   epsilon := one.
   stdout << nl << 'What is ' << (one class) << ' epsilon?' << nl.
   repeat := [
      |sum|
      epsilon := (epsilon / div) perform: asFloat.
      sum := (one + epsilon) perform: asFloat.
      stdout << sum class << ' ' << 1.0 << ' + ' << epsilon
             << ' = ' << sum << nl.
      sum > 1.0
   ].
   repeat whileTrue: [].
].

epsilon value: #asFloatE.
epsilon value: #asFloatD.

