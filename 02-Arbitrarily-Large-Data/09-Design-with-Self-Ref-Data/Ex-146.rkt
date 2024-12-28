#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-146) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 146. Design how-many for NEList-of-temperatures. Doing so
;; completes average, so ensure that average passes all of its tests,
;; too.

; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)

(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

; List-of-temperatures -> Number
; computes the average temperature
;; (define (average alot)
;;   (/ (sum alot) (how-many alot)))

; NEList-of-temperatures -> Number
; adds up the temperatures on the given list
(check-expect
 (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum nel)
  (cond
    [(empty? nel) 0]
    [else (+ (first nel) (sum (rest nel)))]))

;; NEList-of-temperatures -> Number
;; how-many numbers in given NEL
(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)
(define (how-many nel)
  (cond
    [(empty? (rest nel)) 1]
    [else (+ (how-many (rest nel)) 1)]))

;; NEList-of-temperatures -> Number
;; average of the NEList-of-temperatures
(check-expect
 (average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (average nel)
  (/ (sum nel) (how-many nel)))
