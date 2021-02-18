#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: collatz-class.st,v 1.2 2021-02-03 19:43:56-08 - - $"
"http://en.wikipedia.org/wiki/Collatz_conjecture"

Object subclass: Collatz [
   Collatz class >> compute: value [
      |n count show|
      n := value.
      count := 0.
      show := [ stdout << count << ': ' << n << Character nl. ].
      [n > 1] whileTrue: [
         show value.
         count := count + 1.
         n even ifTrue: [n := n / 2]
                ifFalse: [n := n * 3 + 1].
      ].
      show value.
   ]
]

Collatz compute: (Smalltalk arguments at: 1) asInteger.

"TEST: collatz.st 15"

