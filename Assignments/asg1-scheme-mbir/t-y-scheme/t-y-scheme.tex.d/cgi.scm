
;string-index returns the leftmost index in string s
;that has character c

(define string-index
  (lambda (s c)
    (let ((n (string-length s)))
      (let loop ((i 0))
        (cond ((>= i n) #f)
              ((char=? (string-ref s i) c) i)
              (else (loop (+ i 1))))))))

;split breaks string s into substrings separated by character c

(define split
  (lambda (c s)
    (let loop ((s s))
      (if (string=? s "") '()
          (let ((i (string-index s c)))
            (if i (cons (substring s 0 i)
                        (loop (substring s (+ i 1)
                                         (string-length s))))
                (list s)))))))

