#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-167) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

;; Exercise 167. Design the function sum, which consumes a list of
;; Posns and produces the sum of all of its x-coordinates

; Lop (list-of-Posns) is one of:
; - '()
; - (cons (make-posn x y) Lop)

; Lop -> Number
; computes the sum of x-coordiantes of the given list-of-posns
(define (sum an-lop)
  (cond
    [(empty? an-lop) 0]
    [else (+ (posn-x (first an-lop)) (sum (rest an-lop)))]))

(check-expect (sum (cons (make-posn 2 3)
                         (cons (make-posn 3 4) '()))) 5)
(check-expect (sum (cons (make-posn 5 7)
                         (cons (make-posn 2 3)
                               (cons (make-posn 3 4) '())))) 10)
