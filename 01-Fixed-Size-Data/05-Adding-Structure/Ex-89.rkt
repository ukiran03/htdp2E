#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-89) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; Exercise 89.
;; Design the happy-cat world program,
;; which manages a walking cat and its happiness level.
;; Let’s assume that the cat starts out with perfect happiness.


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level.

(define-struct vCat [x score])
;; A VCat is a structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

(define CAT1 (bitmap "./images/cat1.png"))
(define CAT2 (bitmap "./images/cat2.png"))
(define CAT3 (bitmap "./images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CANVAS-WIDTH (* CAT-WIDTH 6))
(define CANVAS-HEIGHT (* CAT-HEIGHT 1.5))
(define CAT-Y (- CANVAS-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-VELOCITY 3)

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define SCORE-FEED 5)                   ; addby 1/5th of gauge
(define SCORE-PET 5)                    ; addby 1/3th of gauge
(define GAUGE-HEIGHT 10)
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))

;; Functions

;; ;; VCat -> VCat
;; (define (happy-cat cat)
;;   (big-bang cat
;;             [to-draw render]
;;             [on-tick tick-handler]
;;             [on-key key-handler]))

;; VCat -> Image
;; Produces an image of a walking cat
;; and a happiness gauge.
;; (define (render cat)
;;   (place-image
;;    (cond
;;      [(= 0 (cat-step (vCat-x cat))) CAT1]
;;      [(= 1 (cat-step (vCat-x cat))) CAT2]
;;      [(= 2 (cat-step (vCat-x cat))) CAT1]
;;      [(= 3 (cat-step (vCat-x cat))) CAT3])
;;    (vCat-x cat) CAT-Y
;;    (if (> (vCat-score cat) ))))

;; Score -> Image
;; Produces a happiness gauge image
(define (draw-gauge level)
  (overlay/align/offset
   "left" "top"
   (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent")
   1 20
   (overlay/align
    "left" "middle"
    (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
    (rectangle level GAUGE-HEIGHT "solid" "red"))))

;; Number -> Number
;; Calculates current step of the cat animation
;; using a given x-coordinate
;; To make a specific cat image of three: CAT1 CAT2 CAT3
;; x:cat-step => 0:0; 4:0; 12:0; 24:0; 36:0; 48:0; 60:1 ...
(define (cat-step x)
  (modulo (round (/ x 12)) 4))

;; VCat -> VCat
(define (tick-handler cat)
  (make-vCat
   (next (vCat-x cat))
   (cond
     [(> (vCat-score cat) SCORE-MAX) SCORE-MAX] ; score never go beyond 100
     [(<= (vCat-score cat) SCORE-DECREASE) 0] ; score never go below 0
     [else (- (vCat-score cat) SCORE-DECREASE)])))

;; Number -> Number
;; Calculates next x-coordinate of the walking cat position,
;; starting over from the left, whenever the cat leaves the canvas
(define (next x)
  (modulo
   (+ CAT-VELOCITY x)
   (round (+ CANVAS-WIDTH (/ CAT-WIDTH 2)))))

;; VCat KeyEvent -> VCat
;; Increases happiness level on "down" and "up" key presses.
(define (key-handler cat key)
  (make-vCat
   (vCat-x cat)
   (cond
     [(key=? key "down") (score+ (vCat-score cat) SCORE-FEED)]
     [(key=? key "up") (score+ (vCat-score cat) SCORE-PET)]
     [else (vCat-score cat)])))

;; Score Number -> Number
;; Increases score value by n-th part
(define (score+ score n)
  (if (> (+ (/ score n) score) SCORE-MAX)
      SCORE-MAX
      (+ (/ score n) score)))
