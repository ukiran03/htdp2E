#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define LENS-R 50)

;; Functions Definitions
(define (traffic-light state duration)
  (big-bang state
            [to-draw render]
            [on-tick next-lens duration]))

;; State -> Image
(define (render state)
  (above (draw-lens "red" state)
         (draw-lens "green" state)
         (draw-lens "yellow" state)))

(define (draw-lens lens state)
  (circle LENS-R (mode lens state) lens))

;; State State -> LensMode
(define (mode lens state)
  (if (string=? lens state) "solid" "outline"))

;; State -> State
(define (next-lens state)
  (cond
    [(string=? "red" state) "green"]
    [(string=? "green" state) "yellow"]
    [(string=? "yellow" state) "red"]
    [else "red"]))
