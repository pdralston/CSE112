#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: wordcount.st,v 1.2 2020-09-01 21:43:18-07 - - $"

"Count lines, words, and bytes in stdin."

Character extend [
   Character class >> vt [^ 11 asCharacter]
   Character class >> initSpaceChars [
      |spaceChars|
      spaceChars := Array new: 256 withAll: false.
      #( #tab #nl #vt #ff #cr #space) do: [:sym|
         spaceChars at: (Character perform: sym) asInteger put: true.
      ].
      ^ spaceChars.
   ]
   spaceChars := Character initSpaceChars.
   isSpace [^ spaceChars at: self asInteger]
].

Object subclass: Counter [
   |lines words bytes prev|
   Counter class >> new [^ super new init]
   init [lines := 0. words := 0. bytes := 0. prev := Character space]
   count: byte [
      byte = Character nl ifTrue: [lines := lines + 1].
      bytes := bytes + 1.
      prev isSpace & byte isSpace not ifTrue: [words := words + 1].
      prev := byte.
   ]
   lines [^ lines]
   words [^ words]
   bytes [^ bytes]
]

nl := Character nl.
counter := Counter new.
[stdin atEnd] whileFalse: [
   |byte|
   byte := stdin next.
   counter count: byte.
].

stdout << counter lines << ' lines, '
       << counter words << ' words, '
       << counter bytes << ' bytes.' << nl.

"TEST: wordcount.st <wordcount.st"
"TEST: ascii | wordcount.st"

