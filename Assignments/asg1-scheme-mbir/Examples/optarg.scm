#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: optarg.scm,v 1.2 2020-08-30 17:48:10-07 - - $

(define (fn arg1 arg2 . rest)
    (printf "~n")
    (printf "arg1: ~s~n" arg1)
    (printf "arg2: ~s~n" arg2)
    (printf "rest: ~s~n" rest))

(fn 'foo 'bar)
(fn 'foo 'bar 'baz)
(fn 'foo 'bar 'baz 'qux)

