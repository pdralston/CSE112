#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: perform.st,v 1.5 2021-02-09 20:01:22-08 - - $"

"Example of perform: methods."

nl := Character nl.

binops := #(#+ #- #* #/ #raisedTo:).

data := #( #(2 3) #(4 5)).

data do: [:opnds|
   |left right|
   left := (opnds at: 1) asFloatD.
   right := (opnds at: 2) asFloatD.
   binops do: [:oper|
      |result|
      stdout << left << ' ' << oper << ' ' << right << ' = '.
      result := (left perform: oper with: right) + 0.0.
      stdout << result << nl.
   ].
].

euler := (-1 sqrt * -1 arcCos) exp + 1.
stdout << euler << nl.
