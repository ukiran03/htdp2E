#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 147. Develop a data definition for NEList-of-Booleans, a
;; representation of non-empty lists of Boolean values. Then redesign
;; the functions all-true and one-true from exercise 140.

;; A NEList-of-Booleans is one of:
;; (cons Boolean '())
;; (cons Boolean NEList-of-Booleans)

;; NEL -> Boolean
;; all-true -> #true if all true
(check-expect (all-true t1) #true)
(check-expect (all-true t2) #false)
(check-expect (all-true t3) #false)
(check-expect (all-true t4) #false)
(define (all-true nel)
  (cond
    [(empty? (rest nel)) (first nel)]
    [else (and (first nel) (all-true (rest nel)))]))

;; NEL -> Boolean
;; one-true -> #true if atleast one true
(check-expect (one-true t1) #true)
(check-expect (one-true t2) #true)
(check-expect (one-true t3) #true)
(check-expect (one-true t4) #false)
(define (one-true nel)
  (cond
    [(empty? (rest nel)) (first nel)]
    [else (or (first nel) (one-true (rest nel)))]))

(define t1 (cons #true (cons #true (cons #true '()))))
(define t2 (cons #true (cons #false (cons #true '()))))
(define t3 (cons #false (cons #false (cons #true '()))))
(define t4 (cons #false (cons #false (cons #false '()))))
