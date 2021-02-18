#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: ashex.st,v 1.1 2021-02-08 12:24:20-08 - - $"

Character extend [
   asHexString [
      |int hexchars|
      hexchars := '0123456789ABCDEF'.
      int := self asInteger.
      ^ (hexchars at: (int quo: 16) + 1) asString,
        (hexchars at: (int rem: 16) + 1) asString.
   ]
].

[stdin atEnd] whileFalse: [
   |char|
   char := stdin next.
   stdout << char << ': ' << char asHexString << Character nl.
]

"TEST: echo Hello World | ashex.st"

