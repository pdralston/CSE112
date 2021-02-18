#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: evalexpr.scm,v 1.13 2020-10-18 11:11:30-07 - - $

;;
;; NAME
;;    eval-apply examples of evaluating expressions.
;;

(define *functions* (make-hash))
(for-each
    (lambda (symfun) (hash-set! *functions* (car symfun) (cadr symfun)))
    `(
        (+    ,+)
        (-    ,-)
        (*    ,*)
        (/    ,/)
        (^    ,expt)
        (sqrt ,sqrt)
        (sqr  ,sqr)

    ))

(define *variables* (make-hash))
(for-each
    (lambda (varval)
        (hash-set! *variables* (car varval) (cadr varval)))
    `(
        (pi    ,(acos -1))
        (e     ,(exp 1))
        (i     ,(sqrt -1))
        (one   1.0)
        (zero  0.0)
    ))

(define NAN (/ 0.0 0.0))

(define (eval-expr expr)
    (cond ((number? expr) (+ expr 0.0))
          ((symbol? expr) (hash-ref *variables* expr 0.0))
          ((pair? expr) 
              (let ((func (hash-ref *functions* (car expr) #f))
                    (opnds (map eval-expr (cdr expr))))
                   (if (not func) NAN
                       (apply func opnds))))
          (else NAN)))

(define (test expr)
    (printf "expr: ~s~n" expr)
    (printf "value: ~s~n" (eval-expr expr))
    (newline))


(test 3)
(test 1/2)
(test '(+ (* 3 4) (* 5 6)))
(test '(+ (^ e (* i pi)) 1))
(test '(/ zero zero))
(test '(/ one zero))
(test '(sqrt (+ (sqr 3) (sqr 4))))
(test '(/ (+ 1) (+ 0)))

(define (dump-hash hash_name)
    (printf "~s:~n" hash_name)
    (hash-for-each (eval hash_name)
        (lambda (key value) (printf "    ~s: ~s~n" key value)) #t)
    (newline))

(dump-hash '*functions*)
(dump-hash '*variables*)

;;TEST: evalexpr.scm

