#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket
(require 2htdp/universe)


(define (posn-up-x pos n)
  (make-posn n (posn-y pos)))

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
