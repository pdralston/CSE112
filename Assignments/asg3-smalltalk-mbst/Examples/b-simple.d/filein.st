#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: filein.st,v 1.1 2021-02-08 12:24:20-08 - - $"

execname := thisContext currentFileName.
nl := Character nl.

stdout << 'Starting ' << execname << '.' << nl.
FileStream fileIn: 'tree.st'.
stdout << 'Finished ' << execname << '.' << nl.

"TEST: filein.st"

