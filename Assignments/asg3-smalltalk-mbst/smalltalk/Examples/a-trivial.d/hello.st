#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: hello.st,v 1.2 2020-09-02 16:18:25-07 - - $"

execname := thisContext currentFileName.
nl := Character nl.

""
"Print a Hello message to stdout and the status to stderr."
"Then exit with status 127."
""

stdout << 'Hello, World!' << nl.

status := 127.
stderr << execname << ': ' << 'Quitting with status ' << status << nl.
ObjectMemory quit: status.

"TEST: hello.st"

