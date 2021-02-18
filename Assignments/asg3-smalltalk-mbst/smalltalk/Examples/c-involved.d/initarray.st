#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: initarray.st,v 1.5 2021-02-11 20:32:10-08 - - $"

Array extend [
   Array class >> new: size with: value [ 
      |this|
      this := Array new: size.
      1 to: size do: [:index| this at: index put: value].
      ^ this
   ]
].

a := Array new: 10 with: 1.0.
stdout << 'a = ' << a << Character nl.

b := Array new: 5 with: #foo.
stdout << 'b = ' << b << Character nl.

u := Array new: 8.
stdout << 'u = ' << u << Character nl.

