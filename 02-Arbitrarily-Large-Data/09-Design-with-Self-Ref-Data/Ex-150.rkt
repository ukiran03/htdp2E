#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-150) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 150. Design the function add-to-pi. It consumes a natural
;; number n and adds it to pi without using the primitive + operation

; N -> Number
; computes (+ n pi) without using +

(check-within (add-to-pi 3) (+ 3 pi) 0.001)

(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))
