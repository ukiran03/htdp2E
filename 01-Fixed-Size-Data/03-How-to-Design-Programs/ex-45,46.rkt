#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-45,46) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

;; Definitions
(define cat1 (bitmap "./images/cat1.png")) ; straight cat
(define cat2 (bitmap "./images/cat2.png")) ; left cat
(define cat3 (bitmap "./images/cat3.png")) ; right cat

(define CANVAS-WIDTH (* (image-width cat1) 5))
(define CANVAS-HEIGHT (* (image-height cat1) 2))

(define WORLD (empty-scene CANVAS-WIDTH CANVAS-HEIGHT))
(define VELOCITY 3)
(define Y-cat (- (image-height WORLD) (/ (image-height cat1) 2)))

;; WorldState -> Image (2 cats)
;; (define (render2 ws)
;;   (cond
;;     [(odd? ws) (place-image cat1 ws Y-cat WORLD)]
;;     [else (place-image cat2 ws Y-cat WORLD)]))
;; (define (render2-v2 ws)
;;   (place-image
;;    (cond
;;      [(= 0 ws) cat3]
;;      [(odd? ws) cat1]
;;      [else cat2])
;;    ws Y-cat WORLD))

;; WorldState -> Image (3 cats)
(define (render3 ws)
  (place-image
   (cond
     [(= 0 (animation-step ws)) cat1]
     [(= 1 (animation-step ws)) cat2]
     [(= 2 (animation-step ws)) cat1]
     [(= 3 (animation-step ws)) cat3])
   ws Y-cat WORLD))

;; WorldState -> Number
;; Cacculates animation step
;; Number -> 0, 1, 2, 3, 0, 1 ..
(check-expect (animation-step 0) 0)     ; 0 
(check-expect (animation-step 7) 1)     ; 7 => (round (/ 7 12)) = 1
(check-expect (animation-step 18) 2)    ; 12 => (round (/ 18 12)) = 2
(define (animation-step ws)
  (modulo (round (/ ws 12)) 4))

;; WorldState: 0 -> 230 -> 0 -> 230 ...
(define (calculate-x ws)
  (modulo (+ VELOCITY ws)
          (round (+ CANVAS-WIDTH
                    (/ (image-width cat1) 2)))))

(define (cat-prog ws)
  (big-bang ws
            [to-draw render3]
            [on-tick calculate-x]))

;; Application
(cat-prog 0)
