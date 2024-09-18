;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname track-obj) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; *Sample Problem* : Your team is designing a game program that keeps
;; track of an object that moves across the canvas at changing speed.
;; The chosen data representation requires two data definitions:

(define-struct ufo [loc vel])
;; A UFO is a structure:
;; (make-ufo Posn Vel)
;; interpretation (make-ufo p v) is at location
;; p moving at velocity

;; The function computes the location of a given UFO after one clock
;; tick passes.

(define-struct vel [deltax deltay])
; A Vel is a structure: 
;   (make-vel Number Number)
; interpretation (make-vel dx dy) means a velocity of 
; dx pixels [per tick] along the horizontal and
; dy pixels [per tick] along the vertical direction
(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))


;; (define-struct posn [x y])
; A Posn is a structure: 
;   (make-posn Number Number)
; interpretation a point x pixels from left, y from top
(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))


;; UFO -> UFO
;; determines where u moves in one clock tick leaves the
;; velocity as is
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))


;; We focus on how to combine the given *Posn* and the given *Vel* in
;; order to obtain the next location of *UFO* using its *Vel*
;; Posn Vel -> Posn
;; adds v to p
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))
