#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/racket/bin/mzscheme -qr
;; $Id: mergesort.scm,v 1.20 2020-10-13 13:17:28-07 - - $

(define (every-other list)
    (if (or (null? list) (null? (cdr list))) list
        (cons (car list) (every-other (cddr list)))))

(define (merge less? list1 list2)
    (cond ((null? list1) list2)
          ((null? list2) list1)
          ((less? (car list1) (car list2))
                  (cons (car list1) (merge less? (cdr list1) list2)))
          (else   (cons (car list2) (merge less? list1 (cdr list2))))
))

(define (merge-sort less? list)
    (if (or (null? list) (null? (cdr list))) list
        (merge less? (merge-sort less? (every-other list))
                     (merge-sort less? (every-other (cdr list))))
))

(define numbers '(3.1415 1.4142 4 22 8 2.7828 77 -33 5 11 -9876))
(define strings '("hello" "world" "foo" "bar" "baz"
                  "Moon" "Sun" "QUX" "1234" "!@#$"))

(printf "~s~n" numbers)
(printf "~s~n" (merge-sort < numbers))
(printf "~s~n" (merge-sort > numbers))

(printf "~s~n" strings)
(printf "~s~n" (merge-sort string<? strings))
(printf "~s~n" (merge-sort string-ci<? strings))

