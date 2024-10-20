#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-92) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 92: Design the cham program, which has the chameleon
;; continuously walking across the canvas from left to right. When it
;; reaches the right end of the canvas, it disappears and immediately
;; reappears on the left. Like the cat, the chameleon gets hungry from
;; all the walking, and, as time passes by, this hunger expresses
;; itself as unhappiness. For managing the chameleon’s happiness
;; gauge, you may reuse the happiness gauge from the virtual cat. To
;; make the chameleon happy, you feed it (down arrow, two points
;; only); petting isn’t allowed. Of course, like all chameleons, ours
;; can change color, too: "r" turns it red, "b" blue, and "g" green.
;; Add the chameleon world program to the virtual cat game and reuse
;; functions from the latter when possible. Start with a data
;; definition, VCham, for representing chameleons.

;; Data Definitions

(define-struct vCham [x color score])
;; VCham is s Structure:
;; (make-vCham Number COLOR Number)
;; (make-vCham x C s), represents a walking cham which is located on
;; an x-coordinate x, has a color c, and a happiness level s

(define CHAM1 (bitmap "./images/cham-92-1.png"))
(define CHAM2 (bitmap "./images/cham-92-2.png"))
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
   (overlay
    (cham-img (vCham-x cham))
    (cham-bg (vCham-color cham)))
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

;; Image Color -> Colored Image
;; Produces given Background to the given Cham Image
(check-expect (cham-bg BLUE)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" BLUE))
(define (cham-bg color)
  (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" color))

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
  (overlay/align/offset
   "left" "top"
   (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent")
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
   (vCham-color cham)
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


;; VCham KeyEvent -> VCham
;; Decreases the happiness score and change the vCham-color
;; Changes chameleon state on a key press:
;; - "down" increases cham's happiness level,
;; - "r" changes cham's color to red,
;; - "b" changes cham's color to blue,
;; - "g" changes cham's color to green.
(check-expect (key-handler (make-vCham 0 WHITE 40) "down")
              (make-vCham 0 WHITE 42))
(check-expect (key-handler (make-vCham 10 WHITE 40) "r")
              (make-vCham 10 RED 40))
(check-expect (key-handler (make-vCham 20 RED 50) "x")
              (make-vCham 20 RED 50))
(define (key-handler cham key)
  (make-vCham
   (vCham-x cham)
   (cond
     [(key=? key "r") RED]
     [(key=? key "g") GREEN]
     [(key=? key "b") BLUE]
     [else (vCham-color cham)])
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
(check-expect (end? (make-vCham 100 RED 80)) #false)
(check-expect (end? (make-vCham 100 RED 0)) #true)
(define (end? cham)
  (= (vCham-score cham) 0))
