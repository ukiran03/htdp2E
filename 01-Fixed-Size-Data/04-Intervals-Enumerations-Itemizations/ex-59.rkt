#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-59) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define LENS-RADIUS 30)

(define RED 0)
(define GREEN 1)
(define YELLOW 0)


; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-lights initial)
  (big-bang initial
            [to-draw tl-render]
            [on-tick tl-next 1]))
;; Numerical Version
(define (traffic-lights-no initial)
  (big-bang initial
            [to-draw tl-render]
            [on-tick tl-next-no 1]))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next state)
  (cond
    [(string=? "red" state) "green"]
    [(string=? "green" state) "yellow"]
    [(string=? "yellow" state) "red"]))

;; (State) Number -> Number
;; 0, 1, 2 -> 1, 2, 0
;; tl-next Numerical version
(define (tl-next-no state)
  (modulo (+ state 1) 3))

;; Defined Constants on top for
;; Colors -> Numbers         
;; (define (next-state state)
;;   (cond
;;     [(= (tl-next-no state) 0) "red"]
;;     [(= (tl-next-no state) 1) "green"]
;;     [(= (tl-next-no state) 2) "yellow"]))

; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render state)
  (above (draw-lens "red" state)
         (draw-lens "green" state)
         (draw-lens "yellow" state)))

;; Light State -> Image
(define (draw-lens lens state)
  (circle LENS-RADIUS (mode lens state) lens))

;; State State -> Mode (outline, solid)
(define (mode lens state)
  (if (string=? lens state) "solid" "outline"))

;; (traffic-lights "red")

;; ------------------------------------------
;; version 2


