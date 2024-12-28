#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-143) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A List-of-temperatures is one of:
; – '()
; – (cons CTemperature List-of-temperatures)

(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

; List-of-temperatures -> Number
; computes the average temperature
(define (average alot)
  (/ (sum alot) (how-many alot)))

; List-of-temperatures -> Number
; adds up the temperatures on the given list
(check-expect
 (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number
; counts the temperatures on the given list
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (length alot)]))

(define (checked-average alot)
  (cond
    [(<= (length alot) 0) (error "empty list: not division by zero")]
    [else (/ (sum alot) (length alot))]))
