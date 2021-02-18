#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: complex.scm,v 1.2 2020-10-07 13:17:08-07 - - $

(define i (sqrt -1))

(define (complex-abs x)
    (sqrt (+ (sqr (real-part x))
             (sqr (imag-part x)))))

(printf "i = ~a~n" i)
(printf "(real-part i) = ~a~n" (real-part i))
(printf "(imag-part i) = ~a~n" (imag-part i))
(printf "(complex-abs i) = ~a~n" (complex-abs i))

