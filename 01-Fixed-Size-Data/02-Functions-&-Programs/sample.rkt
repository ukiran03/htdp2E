#lang racket

(define REGULAR-ATTENDEES 120)
(define REGULAR-PRICE 5.0)
(define AVG-PRICE-CHG 0.1)
(define AVG-ATTENDEES-CHG 15)
(define SHOW-COST 180)
(define SHOW-COST-CHG-PER-H 0.4)
(define NEW-SHOW-COST-CHG-PER-H 1.50)

(define (attendees ticket-price)
  (- REGULAR-ATTENDEES (* (- ticket-price REGULAR-PRICE) (/ AVG-ATTENDEES-CHG AVG-PRICE-CHG))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ SHOW-COST (* SHOW-COST-CHG-PER-H (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price) (cost ticket-price)))

(define (alter-profit ticket-price)
  (- (* (+ 120 (* (/ 15 0.1) (- 5.0 ticket-price))) ticket-price)
     (+ 180 (* 0.04 (+ 120 (* (/ 15 0.1) (- 5.0 ticket-price)))))))

;; sample.rkt> (profit 1)
;; 252.0
;; sample.rkt> (profit 2)
;; 732.0
;; sample.rkt> (profit 3) -- highest profit
;; 912.0
;; sample.rkt> (profit 4)
;; 792.0
;; sample.rkt> (profit 5)
;; 372.0

(define (cost-v2 ticket-price)
  (* NEW-SHOW-COST-CHG-PER-H (attendees ticket-price)))

(define (profit-v2 ticket-price)
  (- (revenue ticket-price) (cost-v2 ticket-price)))

;; sample.rkt> (profit-v2 1)
;; -360.0
;; sample.rkt> (profit-v2 2)
;; 285.0
;; sample.rkt> (profit-v2 3)
;; 630.0
;; sample.rkt> (profit-v2 4) -- highest profit-v2
;; 675.0
;; sample.rkt> (profit-v2 5)
;; 420.0
