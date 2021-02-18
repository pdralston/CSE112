#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: nextbyte.st,v 1.1 2020-08-18 15:12:05-07 - - $"

[stdin atEnd] whileFalse: [
   stdout << stdin nextByte << Character nl.
]
