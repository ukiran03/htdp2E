#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-91) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; Exercise 91. Extend your structure type definition and data
;; definition from exercise 88 to include a direction field. Adjust
;; your happy-cat program so that the cat moves in the specified
;; direction. The program should move the cat in the current
;; direction, and it should turn the cat around when it reaches either
;; end of the scene.

(require 2htdp/image)
(require 2htdp/universe)

;; Constants and Data definitions

(define-struct walk [x delta])
;; A walk is Structure represents
;; (make-walk Number Number)
;; (make-walk x d)
;; x -> x-coordinate
;; delta -> direction change on each move

;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level

(define-struct vCat [walk score])
;; VCat is a structure:
;; (make-vCat Walk Score)
;; Walk -> movement of the cat
;; Score -> happiness score of the cat

(define CAT1 (bitmap "./images/cat1.png"))
(define CAT2 (bitmap "./images/cat2.png"))
(define CAT3 (bitmap "./images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CANVAS-WIDTH (* CAT-WIDTH 6))
(define CANVAS-HEIGHT (* CAT-HEIGHT 1.5))

;; y-coordinate of cat
(define CAT-Y (- CANVAS-HEIGHT (/ CAT-HEIGHT 2)))

;; x-coordinate of cat
(define CAT-X-MAX (- CANVAS-WIDTH (/ CAT-WIDTH 2)))
(define CAT-X-MIN (/ CAT-WIDTH 2))

(define CAT-VELOCITY 3)

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)             ; Defualt decrease
(define SCORE-FEED 5)                   ; the 5th part of the gauge
(define SCORE-PET 3)                    ; the 3rd part of the gauge
(define GAUGE-HEIGHT 10)

;; Frame of the Gauge
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))

;; Functions

;; VCat -> VCat
;; Usage : (happy-cat (make-vCat (make-walk 0 3) 100))
(define (happy-cat cat)
  (big-bang cat
           [to-draw render]
           [on-tick tick-handler]
           [on-key key-handler]
           [stop-when end?]))

;; VCat -> Boolean
;; Identifies if to shut down the program.
(check-expect (end? (make-vCat 100 80)) #false)
(check-expect (end? (make-vCat 100 0)) #true)
(define (end? cat)
 (= (vCat-score cat) 0))

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

;; VCat -> VCat
;; Constructs VCat structure for the current tick.
(check-expect (tick-handler (make-vCat (make-walk 100 3) 15.5))
              (make-vCat (make-walk 103 3) (- 15.5 SCORE-DECREASE)))
(check-expect (tick-handler (make-vCat (make-walk 100 -3) 15.5))
              (make-vCat (make-walk 97 -3) (- 15.5 SCORE-DECREASE)))
(define (tick-handler cat)
  (make-vCat
   (next-walk (vCat-walk cat))
   (next-score (vCat-score cat))))

;; VCat -> Image
;; Produces an Image of a walking cat
;; and a happiness gauge.
(define (render cat)
  (place-image
   (cat-img (walk-x (vCat-walk cat)))
   (walk-x (vCat-walk cat)) CAT-Y
   (if (> (vCat-score cat) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (vCat-score cat)))))

;; VCat -> Image
;; 4 Images to cycle based on given walk-x coordinate
(check-expect (cat-img 12) CAT2)
(check-expect (cat-img 24) CAT1)
(check-expect (cat-img 36) CAT3)
(check-expect (cat-img 48) CAT1)
(define (cat-img x)
  (cond
    [(or (= 0 (cat-step x)) (= 2 (cat-step x))) CAT1]
    [(= 1 (cat-step x)) CAT2]
    [(= 3 (cat-step x)) CAT3]))

;; Number -> Number
;; Calculates current image of the cat animation
;; to place, using a given x-coordinate.
;; 4 images: CAT1, CAT2, CAT1, CAT3.
(define (cat-step x)
  (modulo (round (/ x 12)) 4))


;; Walk -> Walk
;; Calculates next Walk means
;; next x-coordinate and direction
;; CAT-X-MIN 3 -> (+ CAT-X-MIN 3) 3 #Gives: x=MIN+3 and delta=+3
(check-expect (next-walk (make-walk CAT-X-MIN 3))
              (make-walk (+ CAT-X-MIN 3) 3))
;; CAT-X-MIN -3 -> CAT-X-MIN 3 'Gives: x=MIN and delta=+3
(check-expect (next-walk (make-walk CAT-X-MIN -3))
              (make-walk CAT-X-MIN 3))

;; CAT-X-MAX 3 -> CAT-X-MIN -3 #Gives: x=MAX and delta=-3
(check-expect (next-walk (make-walk CAT-X-MAX 3))
              (make-walk CAT-X-MAX -3))
;; CAT-X-MAX -3 -> (- CAT-X-MAX 3) -3 #Gives: x=MAX-3 and delta=-3
(check-expect (next-walk (make-walk CAT-X-MAX -3))
              (make-walk (- CAT-X-MAX 3) -3))
(define (next-walk w)
  (cond
    [(>= CAT-X-MIN (x+delta w))
     (make-walk CAT-X-MIN (abs (walk-delta w)))]
    [(<= CAT-X-MAX (x+delta w))
     (make-walk CAT-X-MAX (- 0 (abs (walk-delta w))))]
    [else (make-walk (x+delta w) (walk-delta w))]))

;; Walk -> Walk
;; Adds the x-coordinate and the delta of the cat
(check-expect (x+delta (make-walk 0 3)) 3)
(check-expect (x+delta (make-walk 10 3)) 13)
(define (x+delta w)
  (+ (walk-x w) (walk-delta w)))

;; Score -> Score
;; Defualt decreasing of score for every tick
(check-expect (next-score 10) 9.9)
(check-expect (next-score 0) SCORE-MIN)
(check-expect (next-score 100) 99.9)
(define (next-score score)
  (cond
    [(> score SCORE-MAX) SCORE-MAX]
    [(<= score SCORE-MIN) SCORE-MIN]
    [else (- score SCORE-DECREASE)]))

;; VCat KeyEvent -> VCat
;; Increases happiness level on "down" and "up" key presses
(check-expect (key-handler (make-vCat (make-walk 0 3) 30) "down")
              (make-vCat (make-walk 0 3) 36))
(check-expect (key-handler (make-vCat (make-walk 10 -3) 30) "up")
              (make-vCat (make-walk 10 -3) 40))
(check-expect (key-handler (make-vCat (make-walk 100 3) 30) "a")
              (make-vCat (make-walk 100 3) 30))
(define (key-handler cat key)
  (make-vCat
   (vCat-walk cat)
   (cond
     [(key=? key "down") (score+ (vCat-score cat) SCORE-FEED)]
     [(key=? key "up") (score+ (vCat-score cat) SCORE-PET)]
     [else (vCat-score cat)])))


;; Score Number -> Number
;; Increases score value by n-th part.
(define (score+ score n)
  (if (> (+ (/ score n) score) SCORE-MAX) ; don't exceed 100
         SCORE-MAX
         (+ (/ score n) score)))
