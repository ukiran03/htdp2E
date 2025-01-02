#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-162) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

; Hourly pay
(define PAY 14)

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* PAY h))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(> (first whrs) 100) (error "No one could work more than 100 hrs")]
    [else (cons (wage (first whrs))
                (wage* (rest whrs)))]))

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '()))
              (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '())))
              (cons 56 (cons 28 '())))
(wage* (cons 4 (cons 2 (cons 102 '()))))
