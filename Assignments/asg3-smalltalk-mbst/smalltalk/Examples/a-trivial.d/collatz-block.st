#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: collatz-block.st,v 1.3 2021-02-03 19:42:19-08 - - $"
"http://en.wikipedia.org/wiki/Collatz_conjecture"

collatz := [:value|
   |n count|
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
].

collatz value: (Smalltalk arguments at: 1) asInteger.

"TEST: collatz.st 15"

