#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: simple-eval.scm,v 1.6 2021-01-12 19:34:27-08 - - $

(define (eval expr)
    (if (number? expr) (+ expr 0.0)
        (apply (car expr)
               (map eval (cdr expr)))))

(define (print-eval expr)
    (printf "~s~n= ~s~n~n" expr (eval expr)))

(print-eval 3)

(print-eval `(,+ 4.14 2.71))

(print-eval `(,sqrt -1))

(print-eval `(,+ (,* 2 3) (,* 4 5)))

(print-eval `(,* (,+ 8 3) (,+ (,* 2 9) 6)))

