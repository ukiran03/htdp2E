#reader(lib "htdp-beginner-reader.ss" "lang")((modname game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket
(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 500 100))
(define DOT (circle 3 "solid" "red"))

;; Posn -> Image
;; add a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20)) (place-image DOT 10 20 MTS))
(define (scene+dot pos)
  (place-image DOT (posn-x pos) (posn-y pos) MTS))

;; Sample Problem x+
;; Posn -> Posn
;; increases the x-coordinate of pos by 3
(check-expect (x+ (make-posn 0 0)) (make-posn 3 0))
;; (define (x+ pos)
;;   (make-posn (+ 3 (posn-x pos)) (posn-y pos)))


;; Posn -> Posn
;; increased the x-coordinate by 3 for every tick
(define (posn-up-x pos n)
  (make-posn n (posn-y pos)))

;; Posn -> Posn
;; increased the x-coordinate by 3 (using posn-up-x) for every tick
(check-expect (x+ (make-posn 0 0)) (make-posn 3 0))
(define (x+ pos)
  (posn-up-x pos (+ (posn-x pos) 3)))

;; Sample Problem: reset-dot
;; Task: design reset-dot, a function that resets the dot when the mouse clicked

;; Posn Number Number MouseEvt - > Posn
;; for mouse clicks, (make-posn x y); otherwise pos
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down") (make-posn 29 31))

(define (reset-dot pos x y mve)
  (cond
    [(or (mouse=? mve "button-down") (mouse=? mve "button-up"))
    (make-posn x y)]
    [else pos]))

;; A Posn represents the state of the world

;; Posn -> Posn
(define (main p0)
  (big-bang p0
            [on-tick x+]
            [on-mouse reset-dot]
            [to-draw scene+dot]))

;; Task: design scene+dot, the function that adds a red dot to the
;; empty canvas at the specified position




