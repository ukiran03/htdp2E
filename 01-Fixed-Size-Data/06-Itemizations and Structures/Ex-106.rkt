#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-106) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;;; Exercise 106: Design the cat-cham world program. Given both a
;;; location and an animal, it walks the latter across the canvas,
;;; starting from the given location. Here is the chosen data
;;; representation for animals

;;where VCat and VCham are your data definitions from exercises 88 and 92.
;; Constants and Data Definitions

(define CANVAS-WIDTH 600)
(define CANVAS-HEIGHT 250)
(define SCENE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent"))

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define VELOCITY 3)

(define GAUGE-HEIGHT 10)
;; Frame of the Gauge
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))

(define CAT1 (bitmap "../.././images/cat1.png"))
(define CAT2 (bitmap "../.././images/cat2.png"))
(define CAT3 (bitmap "../.././images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CAT-Y (- CANVAS-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-FEED 5)
(define CAT-PET 3)

(define CHAM1 (bitmap "../.././images/cham-92-1.png"))
(define CHAM2 (bitmap "../.././images/cham-92-2.png"))
(define CHAM3 (bitmap "../.././images/cham-92-2.png"))
(define CHAM-WIDTH (image-width CHAM1))
(define CHAM-HEIGHT (image-height CHAM2))
(define CHAM-Y (- CANVAS-HEIGHT (/ CHAM-HEIGHT 2) 1))
(define CHAM-FEED 2)
(define RED "red")
(define GREEN "green")
(define BLUE "blue")

;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level

(define-struct vCham [x color score])
;; VCham is a Structure:
;; (make-vCham Number COLOR Number)
;; (make-vCham x C s), represents a walking cham which is located on
;; an x-coordinate x, has a color c, and a happiness level s

(define-struct vCat [x score])
;; VCat is a Structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

;; (define-struct vAnimal [x color score])
;; A VAnimal is either
;; - a VCat
;; - a VAnimal

;; VAnimal -> Number
;; Returns x-coordinate of the animal.
(check-expect (animal-x (make-vCat 50 100)) 50)
(check-expect (animal-x (make-vCham 150 RED 100)) 150)
(define (animal-x vAnimal)
  (if (vCham? vAnimal) (vCham-x vAnimal) (vCat-x vAnimal)))

;; VAnimal -> Number
;; Returns the maximal x-coordinate of the vAnimal.
(check-expect (animal-x-max (make-vCat 50 100)) (round (+ CANVAS-WIDTH (/ CAT-WIDTH 2))))
(check-expect (animal-x-max (make-vCham 50 RED 100)) (round (+ CANVAS-WIDTH (/ CHAM-WIDTH 2))))
(define (animal-x-max vAnimal)
  (round
   ;; (+ CANVAS-WIDTH (/ (if (vCat? vAnimal) CAT-WIDTH CHAM-WIDTH) 2))  ; Or
   (+ CANVAS-WIDTH
      (cond
        [(vCat? vAnimal) (/ CAT-WIDTH 2)]
        [(vCham? vAnimal) (/ CHAM-WIDTH 2)]))))

;; VAnimal -> Number
;; Returns y-coordinate of the vAnimal.
(check-expect (animal-y (make-vCat 50 100)) CAT-Y)
(check-expect (animal-y (make-vCham 50 RED 100)) CHAM-Y)
(define (animal-y vAnimal)
  (if (vCat? vAnimal) CAT-Y CHAM-Y))

;; VAnimal -> Score
;; Returns a gauge score of the vAnimal.
(check-expect (animal-score (make-vCat 50 100)) 100)
(check-expect (animal-score (make-vCham 100 RED 10)) 10)
(define (animal-score vAnimal)
  (if (vCat? vAnimal) (vCat-score vAnimal) (vCham-score vAnimal)))

;; Next Image step of the VAnimal
;; using VAnimal-x -> Step -> Img1 Img2 Img3
(check-expect (animal-step (make-vCat 0 50)) 0)
(check-expect (animal-step (make-vCat 12 50)) 1)
(define (animal-step vAnimal)
  (modulo (round (/ (animal-x vAnimal) 12)) 4))

;; Next Image of the VAnimal
(check-expect (animal-step-image (make-vCat 24 50)) CAT1)
(check-expect (animal-step-image (make-vCham 24 RED 50)) CHAM1)
(check-expect (animal-step-image (make-vCham 12 RED 100)) CHAM2)
(check-expect (animal-step-image (make-vCat 12 100)) CAT2)
(check-expect (animal-step-image (make-vCat 36 50)) CAT3)
(check-expect (animal-step-image (make-vCham 36 RED 100)) CHAM2)
(define (animal-step-image vAnimal)
  (cond
    [(or (= 0 (animal-step vAnimal)) (= 2 (animal-step vAnimal)))
     (cond
       [(vCat? vAnimal) CAT1]
       [(vCham? vAnimal) CHAM1])]
    [(= 1 (animal-step vAnimal))
     (cond
       [(vCat? vAnimal) CAT2]
       [(vCham? vAnimal) CHAM2])]
    [(= 3 (animal-step vAnimal))
     (cond
       [(vCat? vAnimal) CAT3]
       [(vCham? vAnimal) CHAM3])]))

;; make image of the VAnimal
(define (animal-image vAnimal)
  (if (vCat? vAnimal)
      (animal-step-image vAnimal)
      (overlay
       (animal-step-image vAnimal)
       (cham-bg (vCham-color vAnimal)))))

;; Score -> Image
;; Produces happiness guage image of given VAnimal-score
(define (draw-gauge score)
  (overlay/align/offset
   "left" "top" SCENE 1 20
   (overlay/align
    "left" "middle"
    (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
    (rectangle score GAUGE-HEIGHT "solid" "red"))))

;; Cham Color  -> Cham Background
(check-expect (cham-bg BLUE)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" BLUE))
(define (cham-bg color)
  (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" color))

;; Score -> Score
;; Defualt decreasing of score for every tick
(check-expect (next-score (make-vCat 0 10)) 9.9)
(check-expect (next-score (make-vCat 50 15.5)) 15.4)
(check-expect (next-score (make-vCham 0 RED 101)) 100)
(check-expect (next-score (make-vCham 0 GREEN 0)) 0)

(define (next-score vAnimal)
  (cond
    [(> (animal-score vAnimal) SCORE-MAX) SCORE-MAX]
    [(<= (animal-score vAnimal) SCORE-DECREASE) SCORE-MIN]
    [else (- (animal-score vAnimal) SCORE-DECREASE)]))

;; Score Number -> Number
;; Increases score value by n
(check-expect (score+ SCORE-MAX 1) SCORE-MAX)
(check-expect (score+ 30 3) 33)
(define (score+ score n)
  (if (> (+ score n) SCORE-MAX)
      SCORE-MAX
      (+ score n)))

;; Number -> Number
;; Calculates next x-coordinate of the walking VAnimal position,
;; starting over from the left, whenever the VAnimal leaves the canvas.
(check-expect (next (make-vCat 0 100)) 3)
(check-expect (next (make-vCham 100 RED 100)) 103)
(define (next vAnimal)
  (modulo
   (+ VELOCITY (animal-x vAnimal))
   (animal-x-max vAnimal)))

;; VAnimal -> Image
;; Produces an image of a walking VAnimal
;; and its happiness gauge
(define (render vAnimal)
  (place-image
   (animal-image vAnimal)
   (animal-x vAnimal)
   (animal-y vAnimal)
   (if (> (animal-score vAnimal) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (animal-score vAnimal)))))

;; draw the score on the gauge of the given vAnimal
(check-expect (draw-score (make-vCham 20 BLUE 50)) (draw-gauge 50))
(check-expect (draw-score (make-vCat 20 50)) (draw-gauge 50))
(define (draw-score vAnimal)
  (if (> (animal-score vAnimal) SCORE-MAX)
      (draw-gauge SCORE-MAX)
      (draw-gauge (animal-score vAnimal))))

;; VAnimal -> VAnimal
;; Constructs VAnimal structure of the current tick
(define (tick-handler vAnimal)
  (if (vCat? vAnimal)
      (make-vCat (next vAnimal) (next-score vAnimal))
      (make-vCham (next vAnimal)
                  (vCham-color vAnimal)
                  (next-score vAnimal))))

;; Any -> Boolean
;; Check that animal is an element of the VAnimals
(check-expect (vAnimal? (make-vCat 300 60)) #true)
(check-expect (vAnimal? (make-vCham 200 "blue" 77)) #true)
(define (vAnimal? vAnimal)
  (or (vCat? vAnimal) (vCham? vAnimal)))

;; VAnimal -> Boolean
;; End if #true
(define (end? vAnimal)
  (= (animal-score vAnimal) 0))

;; VAnimal KeyEvent -> VAnimal
;; Changes a state of the animal on a key press
;; - "down" increases happiness level,
;; - "up" increases only of vCat's happiness,
;; - "r", "g", "b" changes the vCham's color.
(check-expect (key-handler (make-vCat 0 30) "up") (make-vCat 0 (+ CAT-PET 30)))
(check-expect (key-handler (make-vCat 0 30) "down") (make-vCat 0 (+ CAT-FEED 30)))

(define (key-handler vAnimal key)
  (if (vCat? vAnimal)
      (make-vCat
       (animal-x vAnimal)
       (cond
         [(key=? key "down") (score+ (animal-score vAnimal) CAT-FEED)]
         [(key=? key "up") (score+ (animal-score vAnimal) CAT-PET)]
         [else (animal-score vAnimal)]))
      (make-vCham
       (animal-x vAnimal)
       (cond
         [(key=? key "r") RED]
         [(key=? key "g") GREEN]
         [(key=? key "b") BLUE]
         [else (vCham-color vAnimal)])
       (cond
         [(key=? key "down") (score+ (animal-score vAnimal) CHAM-FEED)]
         [else (animal-score vAnimal)]))))

;; Application
;; VAnimal -> VAnimal
;; Usage:
;; - (cat-cham (make-vCat 0 100))
;; - (cat-cham (make-vCham 0 RED 100))
(define (cat-cham vAnimal)
  (big-bang vAnimal
            [to-draw render]
            [on-tick tick-handler]
            [on-key key-handler]
            [stop-when end?]))
