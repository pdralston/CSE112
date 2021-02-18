(require racket/trace)

;; non tail-recursive
(define (fib-non-tail n)
   (if (<= n 1) n
       (+ (fib-non-tail (- n 1))
          (fib-non-tail (- n 2)))))

;; traceable tail recursive
(define (fib-tail-helper n a b)
    (if (<= n 0) a
        (fib-tail-helper (- n 1) b (+ a b))))
(define (fib-tail n)
    (fib-tail-helper n 0 1))

(trace fib-non-tail)
(trace fib-tail fib-tail-helper)

;; $Id: fibonacci.scm,v 1.3 2020-10-14 21:13:18-07 - - $
