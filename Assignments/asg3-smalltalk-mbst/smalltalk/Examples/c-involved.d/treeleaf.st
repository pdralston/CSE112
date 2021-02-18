#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: treeleaf.st,v 1.2 2020-09-02 19:08:50-07 - - $"

nl := Character nl.

Object subclass: Leaf [
   |value|
   Leaf class >> new: val [^ super new init: val]
   init: val [value := val]
   get [^ value]
   printOn1: stream [
      ^ stream << '(' << self class << ' ' << value printString.
   ]
   printOn: stream [^ (self printOn1: stream) << ')']
   asString1 [^ '(', self class printString, ' ', value printString]
   asString [^ self asString1, ')']
]

Leaf subclass: Tree [
   |left right|
   Tree class >> new: val left: lt right: rt [
      ^ (super new: val) init: lt init: rt.
   ]
   init: lt init: rt [left := lt. right := rt]
   left [^ left]
   right [^ right]
   printOn: stream [
      ^ (self printOn1: stream) << ' ' << left << ' ' << right << ')'.
   ]
   asString [
      ^ self asString1, ' ', left asString, ' ', right asString, ')'.
   ]
]

a := Leaf new: 'a'.
b := Leaf new: 'b'.
c := Tree new: '*' left: a right: b.
d := Leaf new: 'c'.
e := Leaf new: 'd'.
f := Tree new: '*' left: d right: e.
g := Tree new: '+' left: c right: f.

{ a. b. c. d. e. f. g. } do: [:t|
   stdout << nl << 'using printOn: ' << t << nl.
   stdout << 'using asString: ' << t asString << nl.
   stdout << 'using inspect: '. t inspect.
].

"TEST: treeleaf.st"

