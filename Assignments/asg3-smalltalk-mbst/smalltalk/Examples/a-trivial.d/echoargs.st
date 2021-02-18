#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: echoargs.st,v 1.4 2020-02-06 16:31:45-08 - - $"

"Parse command line arguments"

nl := Character nl.

stdout << 'arguments: ' << Smalltalk arguments << nl.

(1 to: Smalltalk arguments size) do: [:index |
   stdout << 'arg[' << index << '] = "'
          << (Smalltalk arguments at: index)
          << '"' << nl.
].

"TEST: echoargs.st foo bar baz"

