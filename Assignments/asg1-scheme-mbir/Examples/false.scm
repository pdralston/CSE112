#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: false.scm,v 1.2 2020-08-30 17:53:59-07 - - $

(define (tf arg)
    (if arg 'true 'false))

(define (fn arg . rem)
    (printf "~n")
    (printf "arg: ~s~n" (tf arg))
    (printf "rem: ~s~n" (tf rem)))

(fn #t)
(fn #f)
(fn 0)
(fn "")
(fn '())

