#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: commandline.scm,v 1.3 2020-08-14 00:38:21-07 - - $

(define args (vector->list (current-command-line-arguments)))

(define (show args)
    (when (not (null? args))
          (let ((arg (car args)))
               (printf "~s ~s ~s~n"
                   (string? arg)
                   (immutable? arg)
                   arg)
          (show (cdr args)))))

(show args)

