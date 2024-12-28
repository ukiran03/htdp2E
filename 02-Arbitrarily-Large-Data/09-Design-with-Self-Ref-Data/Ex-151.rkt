#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 151. Design the function multiply. It consumes a natural
;; number n and multiplies it with a number x without using *.

;; x, n -> Number
;; computes (* x n) without using * operation.

(check-expect (multiply 2 3) 6)
(define (multiply x n)
  (cond
    [(zero? n) 0]
    [else (add x (multiply x (sub1 n)))]))

;; a, b -> Numbers
;; computes addition of two positive numbers without using + operation

(check-expect (add 2 3) 5)
;; (check-expect (add 2 -3) -1)
(check-expect (add 20 30) 50)

(define (add a b)
  (cond
    [(zero? b) a]
    [else (add1 (add a (sub1 b)))]))
