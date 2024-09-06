#reader(lib "htdp-beginner-reader.ss" "lang")((modname sample-4.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define SCENE
  (empty-scene 200 50))

(define DOT
  (circle 10 "solid" "red"))

(define (render pos)
  (place-image DOT pos 25 SCENE))

(define (ctrl pos key)
  (cond
    [(string=? "left" key)
     (- pos 5)]
    [(string=? "right" key)
     (+ pos 5)]
    [else pos]))

(define (start pos)
  (big-bang pos
            [to-draw render]
            [on-key ctrl]))

(define (get pos) (and (> pos 270) (not (= pos 270))))
