#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: eratosthenes.st,v 1.11 2020-09-02 16:20:13-07 - - $"

"Print all prime numbers up to max."

Object subclass: Eratosthenes [
   Eratosthenes class >> primes: max [
      |intFlags primes nonPrimeCount primeIndex|
      intFlags := Array new: max. "nil means prime"
      nonPrimeCount := 0.
      2 to: max sqrt do: [:intIndex| "Punch out nonPrimes."
         intIndex * 2 to: max by: intIndex do:[:nonPrimeIndex|
            (intFlags at: nonPrimeIndex) isNil ifTrue: [
               intFlags at: nonPrimeIndex put: #notPrime.
               nonPrimeCount := nonPrimeCount + 1.
            ].
         ]
      ].
      primes := Array new: max - nonPrimeCount - 1.
      primeIndex := 1.
      2 to: intFlags size do: [:index| "Copy primes to result."
         (intFlags at: index) isNil ifTrue: [
            primes at: primeIndex put: index.
            primeIndex := primeIndex + 1.
         ].
      ].
      ^ primes.
   ]
].

nl := Character nl.
max := (Smalltalk arguments at: 1) asInteger.
stdout << 'Eratosthenes primes: ' << max << nl.
stdout << (Eratosthenes primes: max) << nl.

"TEST: eratosthenes.st 10"
"TEST: eratosthenes.st 100"
"TEST: eratosthenes.st 1000"

