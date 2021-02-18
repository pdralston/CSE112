#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: labelhash.scm,v 1.26 2021-01-14 16:42:58-08 - - $

;;
;; NAME
;;    labelhash - put some labels in a program ibnto a hash table
;;

(define *hash* (make-hash))

(define *program*
    '(
        (1)
        (2 label   (stmt with label))
        (3         (stmt 3))
        (4 nostmt)
        (5         (stmt 5))
        (6 other   (stmt with other))
        (7         (stmt 7))
        (8 end)
    ))

(define (print-program label program)
    (printf "~s: [~n" label)
    (for-each (lambda (line) (printf "   ~s~n" line)) program)
    (printf "]~n"))

(define (put-labels-in-hash program)
    (define (get-label line)
        (and (not (null? line))
             (not (null? (cdr line)))
             (cadr line)))
    (when (not (null? program))
          (let ((label (get-label (car program))))
               (when (symbol? label)
                     (hash-set! *hash* label program)))
          (put-labels-in-hash (cdr program))))


(put-labels-in-hash *program*)

(print-program '*program* *program*)

(hash-for-each *hash*
    (lambda (label program) (print-program label program)))

