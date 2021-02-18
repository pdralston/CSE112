#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: readnums.scm,v 1.4 2020-10-15 11:32:13-07 - - $

;;
;; Read numbers from stdin, stopping at end of file.
;;

{define (readnumber)
        (let ((object (read)))
             (printf "object: ~a~n" object)
             (cond [(eof-object? object) object]
                   [(number? object) (+ object 0.0)]
                   [else (begin (printf "invalid number: ~a~n" object)
                                (readnumber))] )) }

{define (testinput)
        (let ((number (readnumber)))
             (if (eof-object? number)
                 (printf "*EOF* ~a~n" number)
                 (begin (printf "number = ~a~n" number)
                        (testinput)))) }

(testinput)

