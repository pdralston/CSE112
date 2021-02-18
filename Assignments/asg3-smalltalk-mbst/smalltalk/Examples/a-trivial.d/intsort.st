#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: intsort.st,v 1.5 2020-01-31 17:29:51-08 - - $"

nl := Character nl.

sort := SortedCollection new.
sort add: 3; add: 1; add: 4; add: 1; add: 5; add: 9; add: 2; add: 6.
sort inspect.

stdout << 'sort do:' << nl.
sort do: [:int|
   stdout << ' ' << int.
].
stdout << nl.

stdout << 'notEmpty whileTrue:' << nl.
[sort notEmpty] whileTrue: [stdout << ' ' << sort removeFirst].
stdout << nl.

"TEST: intsort.st"

