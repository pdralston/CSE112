#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: hello.st,v 1.2 2020-09-02 16:18:25-07 - - $"

quit := [:message|
   stderr << scriptName.
   message do: [:item| stderr << ': ' << item].
   stderr << Character nl.
   ObjectMemory quit: 1.
].

quit value: #('foobar' 'because').

