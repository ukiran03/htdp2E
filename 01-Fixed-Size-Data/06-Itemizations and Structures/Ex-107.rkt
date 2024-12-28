#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-107) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 107. Design the cham-and-cat program, which deals with
;; both a virtual cat and a virtual chameleon. You need a data
;; definition for a “zoo” containing both animals and functions for
;; dealing with it. Each key event goes to both animals. Each key
;; event applies to only one of the two animals. key-handling function
;; interpret "k" for “kitty” and "l" for lizard

;; Constants and Data Definitions

(define CANVAS-WIDTH 600)
(define CANVAS-HEIGHT 250)
(define SCENE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent"))

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define VELOCITY 3)

(define GAUGE-HEIGHT 10)
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

;; x is x-coordinate of the animal
;; on the canvas

;; A Color is one of the RED, GREEN, BLUE
;; of the Cham

(define-struct vCham [x color score])
;; VAnimal is s Structure:
;; (make-vCham Number COLOR Number)
;; (make-vCham x C s), represents a walking cham which is located on
;; an x-coordinate x, has a color c, and a happiness level s

(define-struct vCat [x score])
;; VCat is a Structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

;; A Focus is a letter either "k" or "l"
;; which only animal to focus
;; k - vCat
;; l - vCham
(define-struct zoo [vCat vCham focus])
;; interpretation: Represensts a state of the focused animal either
;; vCat or vCham at given point

;; animal -> vAnimal
;; vAnimal -> vCat or vCham

;; VAnimal -> Number
;; Returns x-coordinate of the animal
(define (animal-x animal)
  (if (vCat? animal)
      (vCat-x animal)
      (vCham-x animal)))

;; VAnimal -> Number
;; Returns y-coordinate of the animal
(define (animal-y animal)
  (if (vCat? animal) CAT-Y CHAM-Y))

;; VAnimal -> Number
;; Max x-coordinate of the animal
(define (animal-x-max animal)
  (round (+ CANVAS-WIDTH
            (if (vCat? animal)
                (/ CAT-WIDTH 2)
                (/ CHAM-WIDTH 2)))))

;; VAnimal -> Score
(define (animal-score animal)
  (if (vCat? animal)
      (vCat-score animal)
      (vCham-score animal)))

;; Next step for the image to show-up
(define (animal-step animal)
  (modulo (round (/ (animal-x animal) 12)) 4))

;; Image to show-up based on `animal-step'
(define (animal-step-image animal)
  (cond
    [(or (= 0 (animal-step animal)) (= 2 (animal-step animal))) (if (vCat? animal) CAT1 CHAM1)]
    [(= 1 (animal-step animal)) (if (vCat? animal) CAT2 CHAM2)]
    [(= 3 (animal-step animal)) (if (vCat? animal) CAT3 CHAM3)]))

;; make respective Image of the vAnimal
(define (animal-image animal)
  (if (vCat? animal)
      (animal-step-image animal)
      (overlay (animal-step-image animal) (cham-bg (vCham-color animal)))))

;; Cham Color  -> Cham Background
(define (cham-bg color)
  (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" color))

;; VCham Color -> VCham
;; sets color of a cham
(define (cham-with-bg cham color)
  (make-vCham (vCham-x cham) color (vCham-score cham)))

;; Score -> Image
(define (draw-gauge score)
  (overlay/align/offset "left"
                        "top"
                        SCENE
                        1
                        20
                        (overlay/align "left"
                                       "middle"
                                       (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
                                       (rectangle score GAUGE-HEIGHT "solid" "red"))))

;; Score -> Score
(define (next-score animal)
  (cond
    [(> (animal-score animal) SCORE-MAX) SCORE-MAX]
    [(<= (animal-score animal) SCORE-DECREASE) SCORE-MIN]
    [else (- (animal-score animal) SCORE-DECREASE)]))

;; Score Number -> Score
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
(check-expect (next-x (make-vCat 0 100)) 3)
(check-expect (next-x (make-vCham 100 RED 100)) 103)
(define (next-x vAnimal)
  (modulo (+ VELOCITY (animal-x vAnimal)) (animal-x-max vAnimal)))

;; draw the score on the gauge of the given vAnimal
(check-expect (draw-score (make-vCham 20 BLUE 50)) (draw-gauge 50))
(check-expect (draw-score (make-vCat 20 50)) (draw-gauge 50))
(define (draw-score vAnimal)
  (if (> (animal-score vAnimal) SCORE-MAX)
      (draw-gauge SCORE-MAX)
      (draw-gauge (animal-score vAnimal))))

(define (render zoo)
  (if (string=? "k" (zoo-focus zoo))
      (make-animal-frame (zoo-vCat zoo))
      (make-animal-frame (zoo-vCham zoo))))

(define (make-animal-frame animal)
  (place-image (animal-image animal)
               (animal-x animal)
               (animal-y animal)
               (if (> (animal-score animal) SCORE-MAX)
                   (draw-gauge SCORE-MAX)
                   (draw-gauge (animal-score animal)))))

(define (tick-handler zoo)
  (make-zoo
   (make-vCat (next-x (zoo-vCat zoo)) (next-score (zoo-vCat zoo)))
   (make-vCham (next-x (zoo-vCham zoo)) (vCham-color (zoo-vCham zoo)) (next-score (zoo-vCham zoo)))
   (zoo-focus zoo)))

(define (zoo-animal zoo)
  (if (string=? "k" (zoo-focus zoo))
      (zoo-vCat zoo)
      (zoo-vCham zoo)))

;; key-handler
(check-expect (key-handler (make-zoo (make-vCat 0 30) (make-vCham 0 RED 50) "k") "up")
              (make-zoo (make-vCat 0 (+ CAT-PET 30)) (make-vCham 0 RED 50) "k"))

(check-expect (key-handler (make-zoo (make-vCat 0 30) (make-vCham 0 RED 50) "l") "up")
              (make-zoo (make-vCat 0 30) (make-vCham 0 RED 50) "l"))
(define (key-handler zoo key)
  (cond
    [(key=? key "k") (make-zoo (zoo-vCat zoo) (zoo-vCham zoo) "k")]
    [(key=? key "l") (make-zoo (zoo-vCat zoo) (zoo-vCham zoo) "l")]
    [(key=? key "down")
     (make-zoo (if (string=? "k" (zoo-focus zoo))
                   (make-vCat (animal-x (zoo-vCat zoo)) (+ (animal-score (zoo-vCat zoo)) CAT-FEED))
                   (zoo-vCham zoo))
               (if (string=? "l" (zoo-focus zoo))
                   (zoo-vCat zoo)
                   (make-vCham (animal-x (zoo-vCham zoo))
                               (vCham-color (zoo-vCham zoo))
                               (score+ (animal-score (zoo-vCham zoo)) CHAM-FEED)))
               (zoo-focus zoo))]
    [(key=? key "up")
     (if (vCat? (zoo-animal zoo))
         (make-zoo (make-vCat (animal-x (zoo-vCat zoo))
                              (score+ (animal-score (zoo-vCat zoo)) CAT-PET))
                   (zoo-vCham zoo)
                   (zoo-focus zoo))
         zoo)]
    [(and (vCham? (zoo-animal zoo)) (or (key=? key "r") (key=? key "g") (key=? key "b")))
     (make-zoo (zoo-vCat zoo)
               (cond
                 [(key=? key "r") (cham-with-bg (zoo-vCham zoo) RED)]
                 [(key=? key "g") (cham-with-bg (zoo-vCham zoo) GREEN)]
                 [(key=? key "b") (cham-with-bg (zoo-vCham zoo) BLUE)])
               (zoo-focus zoo))]
    [else zoo]))

;; Zoo -> Boolean
;; Identifies if to stop the program.
(check-expect (end? (make-zoo (make-vCat 100 0) (make-vCham 120 RED 10) "l")) #true)
(define (end? zoo)
  (or (= (animal-score (zoo-vCham zoo)) 0) (= (animal-score (zoo-vCat zoo)) 0)))

;; Zoo -> Zoo
;; Usage: (cham-and-cat zoo1)
(define (cham-and-cat zoo)
  (big-bang zoo [to-draw render]
            [on-tick tick-handler]
            [on-key key-handler]
            [stop-when end?]))

;; testing area
(define zoo1 (make-zoo (make-vCat 0 100) (make-vCham 100 RED 100) "k"))
(define zoo2 (make-zoo (make-vCat 0 100) (make-vCham 100 RED 100) "l"))
