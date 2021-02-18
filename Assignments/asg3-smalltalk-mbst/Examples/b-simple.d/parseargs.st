#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: parseargs.st,v 1.1 2021-02-08 12:24:20-08 - - $"
""
"Parse command line arguments"
""

execname := thisContext currentFileName.
nl := Character nl.

stdout << 'execname: ' << execname << nl.
stdout << 'version: ' << Smalltalk version << nl.
stdout << 'hostSystem: ' << Smalltalk hostSystem << nl.
stdout << 'arguments: ' << Smalltalk arguments << nl.

Smalltalk arguments: '-a -b -o: --foo --bar'
do: [:opt :arg |
   stdout << 'opt = "' << opt << '" arg = "' << arg << '"' << nl.
]
ifError: [
   stdout << 'Error: invalid: ' << Smalltalk arguments << nl.
]

"TEST: cmdline.st foo bar baz"

