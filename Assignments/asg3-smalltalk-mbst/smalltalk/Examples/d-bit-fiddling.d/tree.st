#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: tree.st,v 1.2 2020-08-28 10:51:19-07 - - $"

nl := Character nl.

Object subclass: Leaf [
   |char count|
   char [ ^ char ]
   count [ ^ count ]

   Leaf class >> new [ self shouldNotImplement ]

   Leaf class >> new: aChar count: aCount [
      ^ super new setChar: aChar andCount: aCount.
   ]

   setChar: aChar andCount: aCount [
      char := aChar.
      count := aCount.
   ]

   <= other [
      ^ (count < other count)
      | ((count = other count) & (char <= other char))
   ]

   printBase: aStream [
      ^ aStream << self class << '(' << char << ',' << count
   ]

   printOn: aStream [
      (self printBase: aStream) << ')'.
   ]

   depthFirst: visitor prefix: string [
      visitor value: char value: string.
   ]

].


Leaf subclass: Tree [
   |left right|

   Tree class >> new: aChar count: aCount [
      self shouldNotImplement
   ]

   Tree class >> new: aChar count: aCount left: aLeft right: aRight [
      |result|
      result := super new: aChar count: aCount.
      result setLeft: aLeft andRight: aRight.
      ^ result
   ]

   setLeft: aLeft andRight: aRight [
      left := aLeft.
      right := aRight.
   ]

   printOn: aStream [
      (self printBase: aStream) << ',' << left << ',' << right << ')'.
   ]

   depthFirst: visitor prefix: string [
      left depthFirst: visitor prefix: string, '0'.
      right depthFirst: visitor prefix: string, '1'.
   ]

].


a := Leaf new: $a count: 10.
b := Leaf new: $b count: 20.
c := Leaf new: $c count: 15.
t := Tree new: $t count: 30 left: a right: b.
u := Tree new: $u count: 50 left: t right: c.
x := Leaf new: $x count: 20.
z := Tree new: $z count: 80 left: u right: x.

sortcol := SortedCollection new.
sortcol add: t; add: u; add: a; add: b; add: x; add: z; inspect.

stdout << nl << 'Before vising z Tree' << nl.
z depthFirst: [:char :string |
   stdout << '[' << char << ']=' << string << nl.
] prefix: ''.

stdout << nl << 'Before sortcol do: loop' << nl.
sortcol do: [:item |
   stdout << item << nl.
].

stdout << nl << 'Before remove loop.' << nl.
[sortcol notEmpty] whileTrue: [
   |first|
   first := sortcol removeFirst.
   stdout << first << nl.
]

"TEST: tree.st"

