
(load-relative "obj1.scm")


(define (standard-class? x)
  (and (vector? x) (eqv? (vector-ref x 0) standard-class)))
(define (standard-class.slots c) (vector-ref c 1))
(define (standard-class.superclass c) (vector-ref c 2))
(define (standard-class.method-names c) (vector-ref c 3))
(define (standard-class.method-vector c) (vector-ref c 4))
(define (make-standard-class . args)
  (apply send 'make-instance standard-class args))

