#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; *Sample Problem*: Design a function that computes the distance of
;; objects in a 3-dimensional space to the origin.

(define-struct r3 [x y z])
;; An R3 is a structure:
;; (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))


(define-struct 3dposn [x y z])

;; R3 -> Number
;; determines the distance of p to the origin
(define (r3-distance-org pos)
  (exact->inexact
   (sqrt (+ (sqr (3dposn-x pos))
            (sqr (3dposn-y pos))
            (sqr (3dposn-z pos))))))
