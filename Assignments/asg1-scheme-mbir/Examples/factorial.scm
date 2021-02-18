(require racket/trace)

;; non tail-recursive
(define (fac-non-tail n)
   (if (<= n 0) 1
       (* n (fac-non-tail (- n 1)))))

;; tail recursive
(define (fac2 n)
   (define (f n acc)
           (if (<= n 0) acc
               (f (- n 1) (* n acc))))
   (f n 1))

;; traceable tail recursive
(define (fac-tail-helper n acc)
    (if (<= n 0) acc
        (fac-tail-helper (- n 1) (* n acc))))
(define (fac-tail n)
    (fac-tail-helper n 1))

(trace fac-non-tail)
(trace fac2)
(trace fac-tail fac-tail-helper)

;; $Id: factorial.scm,v 1.5 2020-10-13 11:51:11-07 - - $
