#reader(lib "htdp-beginner-reader.ss" "lang")((modname tax) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Price, Percent -> Number
;; computes the tax for given price and percentage
(define (calc-tax percent price)
  (* (/ percent 100) price))


;; Price -> Number
;; computes the amount of tax charged for p
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (>= p 1000)
          (< p 10000)) (calc-tax 5 p)]
    [(>= p 10000) (calc-tax 8 p)]))

(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))
