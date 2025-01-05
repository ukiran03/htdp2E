#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

;; data representation
(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name
; with the pay rate r and the number of hours h

;; data definition
; Low (short for list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the
; hours worked for a number of employees

'()
(cons (make-work "Robby" 11.95 39)
      '())
(cons (make-work "Matthew" 12.95 45)
      (cons (make-work "Robby" 11.95 39)
            '()))

; Use the data definition to explain why these pieces of data belong to "Low".

; Ans: these pieces of data belong to Low, because it consists of
; either an empty list '() with zero workers or (item or list) of Work items
; made up of the data-structure (make-work n r h)

; few other examples
(check-expect (is-low?
               (cons (make-work "kiran" 10.00 10)
                     (cons (make-work "deepu" 10.00 10) '()))) #true)
(define (is-low? lis)
  (cond
    [(empty? lis) #true]
    [else (or (work? (first lis)) (is-low? (rest lis)))]))

; Number Number -> Number
; computes the wage for h hours and rate r of work
(define (wage r h)
  (* r h))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

; Low -> List-of-numbers
; computes the weekly wages for the given records
;; (define (wage*.v2 an-low)
;;   (cond
;;     [(empty? an-low) '()]
;;     [else (cons (wage (work-rate (first an-low))
;;                       (work-hours (first an-low)))
;;                 (wage*.v2 (rest an-low)))]))
;; - Or
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [else (cons (wage.v2 (first an-low))
                (wage*.v2 (rest an-low)))]))

; test
(check-expect
 (wage*.v2 (cons (make-work "Robby" 11.95 39) '()))
 (cons (* 11.95 39) '()))

(check-expect (wage*.v2
               (cons (make-work "Matthew" 12.95 45)
                     (cons (make-work "Robby" 11.95 39)
                           '())))
 (cons (* 12.95 45) (cons (* 11.95 39) '())))
