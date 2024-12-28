#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-110) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 110. A checked version of area-of-disk can also enforce
;; that the arguments to the function are positive numbers, not just
;; arbitrary numbers. Modify checked-area-of-disk in this way.

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v,
; if v is a Positive number
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (positive? v)) (area-of-disk v)]
    [else (error "area-of-disk: Positive number expected")]))
