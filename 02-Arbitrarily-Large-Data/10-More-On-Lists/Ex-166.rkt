#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-166) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

; Exercise 166. wage*.v4 (revised of v3) maps the list of revised work
; records to list of paychecks(revised)

;; data representation
(define-struct work [employee id rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number Number)
; interpretation (make-work n i r h) combines the name n and id
; (number) with the pay rate r and the number of hours h

;; data definition
; Low (short for list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the
; hours worked for a number of employees

;; data representation (structure)
(define-struct paycheck [employee id pay])
; A (piece of) Paycheck is a Structure:
;   (make-paycheck String Number Number)
; interpretation (make-paycheck n N p) combines the name n with the
; his/her id (number) and the amount ot pay p

;; Lop (short for list of paychecks) in one of:
; - '()
; - (cons Paycheck Lop)
; interpretation an instance of Lop represents the
; name(n) & id & amount(p)

'()
(cons (make-paycheck "Robby" 0001 100)
      (cons (make-paycheck "Matthew" 0002 200) '()))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

; Low -> Lop
; computes the list-of-works to list-of-paychecks
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low)
     (cons (make-paycheck (work-employee (first an-low))
                          (work-id (first an-low))
                          (wage.v2 (first an-low)))
           (wage*.v4 (rest an-low)))]))
