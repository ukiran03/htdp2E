#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CAR-B
  (rectangle (+ (image-width BOTH-WHEELS) (* 2 WHEEL-RADIUS)) (* 2 WHEEL-RADIUS) "solid" "red"))
(define MIRRORS
  (beside (rectangle 7 7 "solid" "gray")
          (rectangle 5 5 "solid" "red")
          (rectangle 7 7 "solid" "gray")))
(define CAR-T (underlay (rectangle WHEEL-DISTANCE (* 2 WHEEL-RADIUS) "solid" "red") MIRRORS))

(define CAR (above CAR-T CAR-B BOTH-WHEELS))

(define my-tree
  (overlay/offset
   (overlay/offset
    (overlay/offset (circle 10 "solid" "olivedrab") 10 0 (circle 10 "solid" "olivedrab"))
    0
    -10
    (circle 10 "solid" "olivedrab"))
   0
   20
   (rectangle 10 20 "solid" "brown")))

(define MT-BG (empty-scene 350 100))
(define BACKGROUND (place-image my-tree 300 75 MT-BG))

(define (tock ws)
  (+ ws 2))

; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

(define Y-CAR (- (image-height MT-BG) 17))

(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

(define (main ws)
  (big-bang ws
            [on-tick tock]
            [on-mouse hyper]
            [to-draw render]))
