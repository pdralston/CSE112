#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: outbits.st,v 1.2 2020-08-28 10:51:19-07 - - $"
execname := '$RCSfile: outbits.st,v $' =~ '.*: (.*),v.*' at: 1.

""
" Opens a file given as the first argument and writes out bits."
""

nl := Character nl.

Object subclass: OutBits [
   |bitIndex currentByte myStream|
   OutBits class >> new [self shouldNotImplement]
   OutBits class >> new: fileStream [^ super new init: fileStream]
   init: fileStream [myStream := fileStream.  self clearByte]
   clearByte [bitIndex := 8.  currentByte := 0]
   flushByte [
      bitIndex = 8 ifFalse: [
         myStream nextPutByte: currentByte.
         self clearByte.
      ]
   ]
   writeBit: bit [
      currentByte := currentByte bitAt: bitIndex put: bit.
      bitIndex := bitIndex - 1.
      bitIndex = 0 ifTrue: [self flushByte].
   ]
]


" Output of bitstream hello world."
bitArray := #(
   1 0 1 0   1 0 1 1
   0 1 0 0   1 0 0 0
   0 1 1 0   0 1 0 1
   0 1 1 0   1 1 0 0
   0 1 1 0   1 1 0 0
   0 1 1 0   1 1 1 1
   0 0 1 0   1 1 0 0
   0 0 1 0   0 0 0 0
   0 1 0 1   0 1 1 1
   0 1 1 0   1 1 1 1
   0 1 1 1   0 0 1 0
   0 1 1 0   1 1 0 0
   0 1 1 0   0 1 0 0
   0 0 1 0   0 0 0 1
   1 0 1 1   1 0 1 1
   0 0 0 0   1 0 1 0
   0 0 1 1   0 0 1 0
   1 1 0 1   0 1 1 1
   0 0 1 1   0 0 1 0
   0 0 1 1   1 1 0 1
   0 0 1 1   0 1 0 0
   0 0 0 0   1 0 1 0
).

writeBitArray := [:outfile|
   |outBytes|
   outBytes := OutBits new: outfile.
   bitArray do: [:bit| outBytes writeBit: bit].
   outBytes flushByte.
].

Smalltalk arguments size = 0
   ifTrue: [writeBitArray value: stdout]
   ifFalse: [
      |outfilename|
      outfilename := Smalltalk arguments at: 1.
      [  |outfile|
         outfile := FileStream open: outfilename mode: FileStream write.
         writeBitArray value: outfile.
         outfile close.
      ] on: SystemExceptions.FileError do: [:signal|
         stdout flush.
         stderr << execname << ': ' << filename << ': '
                << signal messageText << nl.
         stderr flush.
      ]
   ]

"TEST: outbits.st"
"TEST: outbits.st | od -c"
"TEST: outbits.st /tmp/outbits.tmp"
"TEST: cat -n /tmp/outbits.tmp"
"TEST: od -c /tmp/outbits.tmp"
"TEST: binarydump/binarydump /tmp/outbits.tmp"
"TEST: binarydump/hexadecimaldump /tmp/outbits.tmp"


