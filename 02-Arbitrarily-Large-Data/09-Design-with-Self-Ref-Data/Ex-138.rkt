#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-137) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; A data definition for representing sequences of amounts of money

; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of-Amount)

(define (sum l)
  (cond
    [(empty? l) 0]
    [(cons? l)
     (+ (first l) (sum (rest l)))]))

(define test
  (cons 12 (cons 23 (cons 34 (cons 45 '())))))

(sum test)
