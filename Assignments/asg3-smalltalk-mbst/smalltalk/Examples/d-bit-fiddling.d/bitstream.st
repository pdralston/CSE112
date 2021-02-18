#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: bitstream.st,v 1.4 2020-08-28 11:09:56-07 - - $"
execname := '$RCSfile: bitstream.st,v $' =~ '.*: (.*),v.*' at: 1.

Character extend [
   isGraph [
      ^ (Character space < self) & (self <= $~)
   ]
   visible [
      self isGraph ifTrue: [^ '$', self asString]
                   ifFalse: [^ self asInteger printStringRadix: 16]
   ]
]

Object subclass: BitStream [
   |bitIndex byte myStream|
   BitStream class >> new: aStream [^ super new init: aStream]
   init: aStream [myStream := aStream. bitIndex := 1]
   nextBit [
      bitIndex = 1 ifTrue: [
         byte := myStream next.
         bitIndex := 9.
      ].
      bitIndex := bitIndex - 1.
      ^byte value bitAt: bitIndex
   ]
   atEnd [^ bitIndex = 1 and: [myStream atEnd]]
   currByte [^ byte]
]

nl := Character nl.
stdinBits := BitStream new: stdin.
count := 0.
[stdinBits atEnd] whileFalse: [
   stdout << stdinBits nextBit.
   count := count + 1.
   count = 4 ifTrue: [stdout << ' '].
   count = 8 ifTrue: [
      stdout << ' ' << stdinBits currByte visible << nl.
      count := 0
   ].
]

"TEST: echo hello world | ./bitstream.st 2>&1"

