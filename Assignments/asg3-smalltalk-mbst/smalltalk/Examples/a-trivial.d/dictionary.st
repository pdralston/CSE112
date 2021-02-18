#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: dictionary.st,v 1.6 2020-08-25 19:22:42-07 - - $"
nl := Character nl.

dict := Dictionary new.

array := #(#foo #bar #baz #quz #hello #world).
array inspect.

(1 to: array size) do: [:index|
   dict add: (array at: index) -> index.
].

dict inspect.

check := [:value|
   |entry|
   entry := dict at: value ifAbsent: [nil].
   stdout << value << '->' << entry << nl.
].

array do: [:value| check value: value].
check value: #foobar.
check value: nil.
check value: 2.

"TEST: dictionary.st"

