#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-170) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

; Exercise 170. Here is one way to represent a phone number:

(define-struct phone [area switch four])
; A Phone is a structure:
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999.
; A Four is a Number between 1000 and 9999.

;; Design the function replace. It consumes and produces a list of
;; Phones. It replaces all occurrence of area code 713 with 281.

; Lop (list-of-phones) is one of:
; - '()
; - (cons (make-phone Three Three Four) Lop)

; Lop -> Lop
; repalces area-code 713 to 281 from given Lop
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [else (cons (make-phone (if (= 713 (phone-area (first lop)))
                                281
                                (phone-area (first lop)))
                            (phone-switch (first lop))
                            (phone-four (first lop)))
                (replace (rest lop)))]))

(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 555 111 5555) (cons (make-phone 713 222 7777) '())))
              (cons (make-phone 555 111 5555) (cons (make-phone 281 222 7777) '())))
