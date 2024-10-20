#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-93) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 93. Copy your solution to exercise 92 and modify the copy
;; so that the chameleon walks across a tricolor background. Our
;; solution uses these colors:

;; Data Definitions

(define-struct vCham [x score])

(define CHAM1 (bitmap "./images/cham-93-1.png"))
(define CHAM2 (bitmap "./images/cham-93-2.png"))
(define CHAM-WIDTH (image-width CHAM1))
(define CHAM-HEIGHT (image-height CHAM2))
(define CANVAS-WIDTH (* CHAM-WIDTH 6))
(define CANVAS-HEIGHT (* CHAM-HEIGHT 3))

;; y-coordinate of cham
(define CHAM-Y (- CANVAS-HEIGHT (/ CHAM-HEIGHT 2) 1))
(define CHAM-VELOCITY 3)

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)             ; Defualt decrease
(define SCORE-FEED 2)                   ; the 5th part of the gauge
(define GAUGE-HEIGHT 10)

;; Frame of the Gauge
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))

(define RED "red")
(define GREEN "green")
(define BLUE "blue")
(define WHITE "white")                  ; Normal Color

(define COLOR-WIDTH (/ CANVAS-WIDTH 3))
(define COLOR-HEIGHT CANVAS-HEIGHT)
(define BG
  (beside (empty-scene COLOR-WIDTH CANVAS-HEIGHT GREEN)
          (empty-scene COLOR-WIDTH CANVAS-HEIGHT WHITE)
          (empty-scene COLOR-WIDTH CANVAS-HEIGHT RED)))

;; Functions

;; VCham -> VCham
;; Usage : (happy-cham (make-vCham 0 WHITE 100))
(define (happy-cham cham)
  (big-bang cham
            [to-draw render]
            [on-tick tick-handler]
            [on-key key-handler]
            [stop-when end?]))

;; VCham -> Image
;; Produces an Image of a walking cham
;; and its happiness gauge.
(define (render cham)
  (place-image
    (cham-img (vCham-x cham))
   (vCham-x cham) CHAM-Y
   (if (> (vCham-score cham) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (vCham-score cham)))))

;; Number -> Image
;; by using cham-step, produces the cham image to show
;; on the animation
(check-expect (cham-img 12) CHAM2)
(check-expect (cham-img 24) CHAM1)
(check-expect (cham-img 36) CHAM2)
(check-expect (cham-img 48) CHAM1)
(define (cham-img x)
  (cond
    [(or (= 0 (cham-step x))
         (= 2 (cham-step x))) CHAM1]
    [else CHAM2]))

;; Number -> Number
;; Calculates current image of the cham to show
;; using vCham-x: CHAM1 CHAM2
(check-expect (cham-step 0) 0)
(check-expect (cham-step 4) 0)
(check-expect (cham-step 12) 1)
(define (cham-step x)
  (modulo (round (/ x 12)) 4))

;; Score -> Image
;; Produces a happiness gauge image
(define (draw-gauge score)
  (underlay/align/offset
   "left" "top"
   ;; (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent")
   BG
   1 20
   (overlay/align
    "left" "middle"
    (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
    (rectangle score GAUGE-HEIGHT "solid" "red"))))

;; VCham -> VCham
;; Constructs VCham structure of the current tick
(define (tick-handler cham)
  (make-vCham
   (next (vCham-x cham))
   (next-score (vCham-score cham))))

;; Score -> Score
;; Defualt decreasing of score for every tick
(check-expect (next-score 101) 100)
(check-expect (next-score 10) 9.9)
(check-expect (next-score 0) SCORE-MIN)
(check-expect (next-score 100) 99.9)
(define (next-score score)
  (cond
    [(> score SCORE-MAX) SCORE-MAX]
    [(<= score SCORE-DECREASE) SCORE-MIN]
    [else (- score SCORE-DECREASE)]))

;; Number -> Number
;; Calculates next x-coordinate of the walking cham position,
;; starting over from the left, whenever the cham leaves the canvas.
(define (next x)
  (modulo
   (+ CHAM-VELOCITY x)
   (round (+ CANVAS-WIDTH (/ CHAM-WIDTH 2)))))


(define (key-handler cham key)
  (make-vCham
   (vCham-x cham)
   (cond
     [(key=? key "down") (score+ (vCham-score cham) SCORE-FEED)]
     [else (vCham-score cham)])))

;; Score Number -> Number
;; Increases score value by n-th part.
(check-expect (score+ SCORE-MAX 1) SCORE-MAX)
(check-expect (score+ 30 3) 33)
(define (score+ score n)
  (if (> (+ score n) SCORE-MAX)
      SCORE-MAX
      (+ score n)))

;; VCham -> Boolean
;; Identifies if to shut down the program.
(check-expect (end? (make-vCham 100 80)) #false)
(check-expect (end? (make-vCham 100 0)) #true)
(define (end? cham)
  (= (vCham-score cham) 0))
