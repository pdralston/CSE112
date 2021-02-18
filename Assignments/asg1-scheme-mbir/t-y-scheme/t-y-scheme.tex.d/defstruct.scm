
;(defstruct structname [field | (field default-value)] ...)
;
;creates
;the constructor make-structname
;the predicate structname?
;the accessors structname.field (for each field)
;the setters set!structname.field (for each field)
;
;make-structname can take {field init-value} arguments,
;in which it case it sets field to init-value.  Otherwise,
;it sets field to default-value, if such was provided in
;the defstruct call

(load-relative "listpos.scm")

