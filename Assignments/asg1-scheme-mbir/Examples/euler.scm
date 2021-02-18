#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: euler.scm,v 1.6 2020-09-06 11:23:57-07 - - $

(define i (sqrt -1))
(define pi (acos -1))

(define euler-exp '(lambda (x) (exp (* i x))))
(define euler-trig '(lambda (x) (+ (cos x) (* i (sin x)))))

(define (show expr)
    (printf "~s = ~s~n"  expr (eval expr)))

(show 'i)
(show 'pi)

(show 'euler-exp)
(show 'euler-trig)

(show '((eval euler-exp) pi))
(show '((eval euler-trig) pi))
(show '(- ((eval euler-exp) pi) ((eval euler-trig) pi)))

(show '((eval euler-exp) 0))
(show '((eval euler-trig) 0))
(show '(- ((eval euler-exp) 0) ((eval euler-trig) 0)))

(define (digits fraction)
    (let ((sum (+ 1 fraction)))
         (show `(+ 1 ,fraction))
         (when (> sum 1) (digits (/ fraction 10)))))

(printf "~nWhat is epsilon?~n")
(digits 0.0000001)

