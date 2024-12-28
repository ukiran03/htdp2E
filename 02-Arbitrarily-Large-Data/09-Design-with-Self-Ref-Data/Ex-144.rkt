#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-144) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; implementing with new NEList-of-temperatures


; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature List-of-temperatures)

(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

(check-expect
 (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum nel)
  (cond
    [(empty? (rest nel)) (first nel)]
    [else (+ (first nel) (sum (rest nel)))]))
