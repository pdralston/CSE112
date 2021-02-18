#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: sorted-names.st,v 1.8 2021-02-10 23:27:46-08 - - $"

Object subclass: Name [
   |first last|
   first [^ first]
   last [^ last]
   Name class >> new [self shouldNotImplement]

   Name class >> new: last first: first [
      ^ super new init: last first: first.
   ]

   init: aLast first: aFirst [
      first := aFirst.
      last := aLast.
   ]

   <= other [
      last = other last
         ifTrue: [^ first <= other first]
         ifFalse: [^ last <= other last].
   ]

   printOn: aStream [
      ^ aStream << last << ', ' << first.
   ]
]

royal_names := #(

   #('Anne' 'Boleyn')
   #('Anne' 'Cleves')
   #('Catherine' 'Howard')
   #('Catherine' 'Parr')
   #('Charles' 'Stuart')
   #('Edward' 'Tudor')
   #('Elizabeth' 'Tudor')
   #('Henry' 'Plantagenet')
   #('Henry' 'Tudor')
   #('James' 'Stuart')
   #('Jane' 'Seymour')
   #('Mary' 'Stuart')
   #('Mary' 'Tudor')
   #('Richard' 'Plantagenet')

).

sorted_names := SortedCollection new.
royal_names do: [:name|
   sorted_names add: (Name new: (name at: 2) first: (name at: 1))
].

nl := Character nl.
sorted_names do: [:item| stdout << item << nl.].


