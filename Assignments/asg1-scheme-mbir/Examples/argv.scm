#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: argv.scm,v 1.6 2020-10-07 18:11:07-07 - - $

(define *run-file*
    (let-values
        (((dirname basename dir?)
            (split-path (find-system-path 'run-file))))
        basename)
)

(define *arg-list* (vector->list (current-command-line-arguments)))

(let-values
    (((dirname basename dir?)
        (split-path (find-system-path 'run-file))))
    (printf "dirname: ~a~n" dirname)
    (printf "basename: ~a~n" basename)
    (printf "dir?: ~a~n" dir?)
)

(printf "*run-file*: ~a~n" *run-file*)
(for-each (lambda (x) (printf "arg: ~a~n" x))  *arg-list*)

