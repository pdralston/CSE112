
(define bike-class
  (create-class
   ()
   (frame size parts chain tires)
   (check-fit (lambda (me inseam)
                (let ((bike-size (slot-value me 'size))
                      (ideal-size (* inseam 3/5)))
                  (let ((diff (- bike-size ideal-size)))
                    (cond ((<= -1 diff 1) 'perfect-fit)
                          ((<= -2 diff 2) 'fits-well)
                          ((< diff -2) 'too-small)
                          ((> diff 2) 'too-big))))))))

(define my-bike
  (make-instance bike-class
                 'frame 'titanium
                 'size 21
                 'parts 'ultegra
                 'chain 'sachs
                 'tires 'continental))

