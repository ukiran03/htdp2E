#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-145) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 145. Design the sorted>? predicate, which consumes a
;; NEList-of-temperatures and produces #true if the temperatures are
;; sorted in descending order. That is, if the second is smaller than
;; the first, the third smaller than the second, and so on. Otherwise
;; it produces #false.

; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature List-of-temperatures)

(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

;; NEList-of-temperatures -> Boolean
(check-expect (sorted>?
               (cons 3 (cons 2 (cons 1 '())))) #true)
(define (sorted>? nel)
  (cond
    [(empty? (rest nel)) #true]
    [(> (first nel) (first (rest nel)))
     (sorted>? (rest nel))]
    [else #false]))

(sorted>?
 (cons 2 (cons 2 (cons 1 '()))))
