#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; (define (number->square s)
;;   (square s "solid" "red"))
;; (define (reset s ke)
;;   100)

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (main y)
  (big-bang y [on-tick sub1] [stop-when zero?] [to-draw place-dot-at] [on-key stop]))

(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))
(define (stop y ke)
  0)

(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))
