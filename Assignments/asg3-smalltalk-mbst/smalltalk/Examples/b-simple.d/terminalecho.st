#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: terminalecho.st,v 1.1 2021-02-08 12:24:20-08 - - $"
execname := '$RCSfile: terminalecho.st,v $' =~ '.*: (.*),v.*' at: 1.

" "
" Show how to interact with a terminal readline line by line. "
" Calling stdin atEnd always reads the next line from the "
" buffer, so it can not be called before the prompt. "
" "

nl := Character nl.

stdinEnd := false.
[stdinEnd] whileFalse: [
   |line|
   stdout << 'Enter:' << nl.
   stdout flush.
   stdin atEnd
      ifTrue: [
         stdinEnd := true.
         stdout << 'stdinEnd' << nl.
         stdout flush.
      ]
      ifFalse: [
         line := stdin nextLine.
         stdout << 'Echo: ' << line << nl.
         stdout flush.
      ]
].
