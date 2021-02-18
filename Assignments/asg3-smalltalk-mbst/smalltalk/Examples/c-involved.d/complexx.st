#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: complexx.st,v 1.4 2020-11-17 12:22:22-08 - - $"

"Called Complexx to avoid confusion with library class Complex."

Object subclass: Complexx [
   |real imag|

   Complexx class >> new [^ super new init: 0.0 imag: 0.0]
   
   Complexx class >> new: re [^ super new init: re imag: 0.0]

   Complexx class >> new: re imag: im [^ super new init: re imag: im]
    
   init: re imag: im [real := re asFloatD. imag := im asFloatD.]
    
   real [^ real]
   imag [^ imag]

   + val [^ Complexx new: real + val real
                    imag: imag + val imag
   ]

   - val [^ Complexx new: real - val real
                    imag: imag - val imag
   ]

   * val [
       ^ Complexx new: (real * val real) - (imag * val imag)
                 imag: (imag * val real) + (real * val imag)
   ]

   / val [
      |d r i|
      d := (val real * val real) + (val imag * val imag).
      r := ((real * val real) + (imag * val imag)).
      i := ((imag * val real) - (real * val imag)).
      ^ Complexx new: r / d imag: i / d
   ]
    
   =  val [^ (real = val real) & (imag = val imag)]
   ~= val [^ (self = val) not ]

   abs [^ (real squared + imag squared) sqrt]

   <  val [^ self shouldNotImplement]
   <= val [^ self shouldNotImplement]
   >  val [^ self shouldNotImplement]
   >= val [^ self shouldNotImplement]
    
   printOn: aStream [^ aStream << '(' << real << ',' << imag << ')']

].

nl := Character nl.
i := Complexx new: 0 imag: 1.
i inspect.
stdout << 'i = ' << i << nl.
neg1 := Complexx new: -1 imag: 0.
stdout << 'neg1 = ' << neg1 << nl.
a := Complexx new: 3 imag: 4.
b := Complexx new: 5 imag: 6.
c := a * b.
stdout << 'c = ' << c << nl.

"TEST: complexx.st"

