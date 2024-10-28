#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-97) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)


(define WIDTH 200)
(define HEIGHT 200) ; 450
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define UFO-IMG
  (underlay/align/offset "center"
                         "top"
                         (wedge 10 180 "solid" "gray")
                         0
                         9
                         (ellipse 35 15 "solid" "olivedrab")))
(define TANK
  (overlay/align/offset "center"
                        "top"
                        (rectangle 5 15 "solid" "black")
                        0
                        9
                        (overlay/align "center"
                                       "center"
                                       (circle 9 "solid" "black")
                                       (rectangle 30 25 "solid" "yellowgreen"))))
(define TANK-HEIGHT (image-height TANK))

;; A Tank's y-coordinate is fixed
(define TANK-Y (+ (- HEIGHT TANK-HEIGHT) (/ TANK-HEIGHT 2)))

(define MISSILE (ellipse 6 16 "solid" "red"))

;; A UFO is a Posn Structure
;; interpretation: (make-posn x y)
;; is UFO's location; x and y coordinate.

(define-struct tank [loc vel])
;; A Tank is a Structure:
;; (make-tank Number Number).
;; interpretation (make-tank x dx) specifies the position:
;; x (x-coordinate) and dx (tank's speed pixels/tick)

;; A Missile is a Posn Structure.
;; interpretation (make-posn x y)
;; is the missile's location; x and y coordinate.

(define-struct aim [ufo tank])
;; interpretation:
;; (make-aim (make-posn x y)
;;           (make-tank x dx))
;; for the time period when the player is trying to get the tank in
;; position for a shot

(define-struct fired [ufo tank missile])
;; interpretation:
;; (make-fired (make-posn x y)
;;             (make-tank x dx)
;;             (make-posn x y))
;; for representing states after the missile is fired

;; SIGS -> state of Space Invader Game
;; A SIGS is one of:
;; - (make-aim UFO Tank)
;; - (make-fired UFO Tank Missile)
;; interpretation represents the complete state of
;; Space Invader Game

;; The Design Recipe suggests that if the each piece of data comes
;; with their own data definition, like
;; (make-aim (UFO)
;;           (Tank))
;; we consider defining helper (auxilary) functions
;; So, Here `tank-render' and `ufo-render' are whishlist functions.

;; Tank Image -> Image
;; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (+ (tank-loc t) (tank-vel t)) TANK-Y im))

;; UFO Image -> Image
;; adds u to the given image im
;; (define (ufo-render u im) im)
(define (ufo-render u im)
  (place-image UFO-IMG (posn-x u) (posn-y u) im))

;; Missile Image -> Image
;; adds m to the given image im
;; (define (missile-render m im) im)
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))

;; Testing Area
(define s1 (make-aim (make-posn 10 20) (make-tank 28 -3)))
(define s2 (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))
(define s3 (make-fired (make-posn 10 20) (make-tank 28 -3) (make-posn 32 (- HEIGHT TANK-HEIGHT 10))))

;; Rendering Image Structure: tank-render ontop of missile-render ontop of ufo-render
(define (fired-test s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s) (ufo-render (fired-ufo s) BACKGROUND))))
(define (aim-test s)
  (tank-render (aim-tank s) (ufo-render (aim-ufo s) BACKGROUND)))

(define (result1 s)
  (tank-render (fired-tank s)
               (ufo-render (fired-ufo s) (missile-render (fired-missile s) BACKGROUND))))

(define (result2 s)
  (ufo-render
   (fired-ufo s)
   (tank-render
    (fired-tank s)
    (missile-render (fired-missile s) BACKGROUND))))
