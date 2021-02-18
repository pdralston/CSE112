#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: string.st,v 1.1 2021-02-08 12:24:20-08 - - $"

nl := Character nl.

s := 'Hello world'.
stdout << s << nl.

(1 to: s size) do: [:i|
   |c ci|
   ci := s byteAt: i.
   cc := ci asCharacter.
   stdout << i << ' ' << ci << '=' << cc << ';' << nl.
   (cc = $o) ifTrue: [ stdout << 'True' << nl. ].
]

"TEST: string.st"

