#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: mbir.scm,v 1.9 2021-01-12 11:57:59-08 - - $
;;
;; NAME
;;    mbir.scm filename.mbir
;;
;; SYNOPSIS
;;    mbir.scm - mini basic interper
;;
;; DESCRIPTION
;;    The file mentioned in argv[1] is read and assumed to be an mbir
;;    program, which is the executed.  Currently it is only printed.
;;

(define *DEBUG* #f)
(define *STDIN* (current-input-port))
(define *STDOUT* (current-output-port))
(define *STDERR* (current-error-port))
(define *ARG-LIST* (vector->list (current-command-line-arguments)))

(define *stmt-table*     (make-hash))
(define *function-table* (make-hash))
(define *var-table*      (make-hash))
(define *array-table*    (make-hash))
(define *label-table*    (make-hash))

(for-each (lambda (var) (hash-set! *var-table* (car var) (cadr var)))
   `(
        (eof  ,0.0)
        (e    ,(exp 1.0))
        (nan  ,(/ 0.0 0.0))
        (pi   ,(acos -1))
        (i    ,(sqrt -1))
    ))

(define *RUN-FILE*
    (let-values
        (((dirname basename dir?)
            (split-path (find-system-path 'run-file))))
        (path->string basename)))

(define (die list)
    (for-each (lambda (item) (fprintf *STDERR* "~a " item)) list)
    (fprintf *STDERR* "~n")
    (when (not *DEBUG*) (exit 1)))

(define (dump . args)
    (when *DEBUG*
        (printf "DEBUG:")
        (for-each (lambda (arg) (printf " ~s" arg)) args)
        (printf "~n")))

(define (usage-exit)
    (die `("Usage: " ,*RUN-FILE* " [-d] filename")))

(define (line-number line)
    (car line))

(define (line-label line)
    (let ((tail (cdr line)))
         (and (not (null? tail))
              (symbol? (car tail))
              (car tail))))

(define (line-stmt line)
    (let ((tail (cdr line)))
         (cond ((null? tail) #f)
               ((pair? (car tail)) (car tail))
               ((null? (cdr tail)) #f)
               (else (cadr tail)))))

(define (not-implemented function args . nl)
    (printf "(NOT-IMPLEMENTED: ~s ~s)" function args)
    (when (not (null? nl)) (printf "~n")))

(define *functions* (make-hash))

(define (log10 value) (log value 10))

(define (trunc value)
    (cond
        ((value > 0) (floor value))
        ((value < 0) (ceiling value))))

(define (asub args)
    (let* ((array (cadr args))
           (index (exact-round (eval-expr (caddr args)))))
        (vector-ref  (hash-ref *array-table* array) index)
    )
)
(for-each
    (lambda (symfun) (hash-set! *functions* (car symfun) (cadr symfun)))
    `(
        (+     ,+)
        (-     ,-)
        (*     ,*)
        (/     ,/)
        (^     ,expt)
        (abs   ,abs)
        (acos  ,acos)
        (asin  ,asin)
        (atan  ,atan) 
        (ceil  ,ceiling) 
        (cos   ,cos) 
        (exp   ,exp) 
        (floor ,floor)
        (log   ,log) 
        (log10 ,log10) 
        (round ,round) 
        (sin   ,sin) 
        (sqrt  ,sqrt) 
        (tan   ,tan) 
        (trunc ,trunc)
    ))

(define NAN (/ 0.0 0.0))

(define (eval-expr expr)
    (cond ((number? expr) (+ expr 0.0))
          ((symbol? expr) (hash-ref *var-table* expr 0.0))
          ((pair? expr) 
               (cond 
                   ((eq? (car expr) 'asub) (asub expr))
               (else
                   (let ((func (hash-ref *functions* (car expr) #f))
                         (opnds (map eval-expr (cdr expr))))
                            (if (not func) NAN
                                (apply func opnds))))))
    (else NAN)))

(define (interp-dim args continuation)
    (let* ((listName (cadar args))
          (listLen  (exact-round (eval-expr (caddar args)))))
          (hash-set! *array-table* listName (make-vector listLen 0.0))
    )
    (interp-program continuation))

(define (let-helper args)
    (cond  
        ((symbol? (car args))
            (let* ((value (eval-expr (cadr args)))
                   (varName (car args)))
                (hash-set! *var-table* varName value)))
        ((list? (car args))
            (let* ((array (cadar args))
                   (index (exact-round (eval-expr (caddar args))))
                   (value (eval-expr (cadr args))))
                (vector-set! (hash-ref *array-table* array) index value)))
    (else (print "Invalid Variable type"))))

(define (interp-let args continuation)
    (let-helper args)
    (interp-program continuation))

(define (interp-goto args continuation)
    (let ((program (hash-ref! *label-table* (car args) #f)))
        (if program 
            (interp-program program)
            (exit 1)
        ))
)

(define (interp-if args continuation)
    (if (eval args) #t #f)
    (interp-program continuation))

(define (interp-print args continuation)
    (define (print item)
        (if (string? item)
            (printf "~a" item)
            (printf " ~a" (eval-expr item))))
    (for-each print args)
    (printf "~n");
    (interp-program continuation))

(define (interp-input args continuation)
    {define (readnumber)
        (let ((object (read)))
             (cond [(eof-object? object) (hash-set! *var-table* 'eof 1.0) NAN]
                   [(number? object) (+ object 0.0)]
                   [else NAN] )) }
    (for-each (lambda (var) (
        cond [(eqv? (hash-ref *var-table* 'eof) 1.0)
                    (let-helper (list var NAN))]
              [else (let-helper (list var (readnumber)))]
    ))args)
    (interp-program continuation))

(for-each (lambda (fn) (hash-set! *stmt-table* (car fn) (cadr fn)))
   `(
        (dim   ,interp-dim)
        (let   ,interp-let)
        (goto  ,interp-goto)
        (if    ,interp-if)
        (print ,interp-print)
        (input ,interp-input)
    ))

(define (interp-program program)
    (when (not (null? program))
          (let ((line (line-stmt (car program)))
                (continuation (cdr program)))
               (if line
                   (let ((func (hash-ref *stmt-table* (car line) #f)))
                        (func (cdr line) continuation))
                   (interp-program continuation)))))

(define (scan-for-labels program)
    (define (get-label line)
        (and (not (null? line))
             (not (null? (cdr line)))
             (cadr line)))
    (when (not (null? program))
          (let* (( line (car program))
               (label (get-label line)))
               (when (symbol? label)
                     (hash-set! *label-table* label program)))
          (scan-for-labels (cdr program))))

(define (readlist filename)
    (let ((inputfile (open-input-file filename)))
         (if (not (input-port? inputfile))
             (die `(,*RUN-FILE* ": " ,filename ": open failed"))
             (let ((program (read inputfile)))
                  (close-input-port inputfile)
                         program))))

(define (dump-program filename program)
    (define (dump-line line)
        (dump (line-number line) (line-label line) (line-stmt line)))
    (dump *RUN-FILE* *DEBUG* filename)
    (dump program)
    (for-each (lambda (line) (dump-line line)) program))

(define (main arglist)
    (cond ((null? arglist)
                (usage-exit))
          ((string=? (car arglist) "-d")
                (set! *DEBUG* #t)
                (printf "~a: ~s~n" *RUN-FILE* *ARG-LIST*)
                (main (cdr arglist)))
          ((not (null? (cdr  arglist)))
                (usage-exit))
          (else (let* ((mbprogfile (car arglist))
                       (program (readlist mbprogfile)))
                (begin (when *DEBUG* (dump-program mbprogfile program))
                       (scan-for-labels program)
                       (interp-program program))))))

(main *ARG-LIST*)