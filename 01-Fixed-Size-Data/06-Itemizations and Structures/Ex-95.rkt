#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-95) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 300)
(define HEIGHT 450)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define UFO (underlay/align/offset
             "center" "top" (wedge 10 180 "solid" "gray")
             0 9 (ellipse 35 15 "solid" "olivedrab")))
(define TANK (overlay/align/offset
              "center" "top" (rectangle 5 15 "solid" "black") 0 9
              (overlay/align
                   "center" "center" (circle 9 "solid" "black")
                   (rectangle 30 25 "solid" "yellowgreen"))))
(define TANK-HEIGHT (image-height TANK))
(define MISSILE (ellipse 6 16 "solid" "red"))

(define-struct aim [ufo tank])
;; for the time period when the player is trying to get the tank in
;; position for a shot

(define-struct fired [ufo tank missile])
;; for representing states after the missile is fired

;; A Ufo is Posn.
;; interpretation (make-posn x y) is the UFO's location
;; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
;; A Tank is a Structure:
;; (make-tank Number Number).
;; interpretation (make-tank x dx) specifies the position:
;; x (x-coordinate) and dx (tank's speed pixels/tick)

;; A Missile is a Posn.
;; interpretation (make-posn x y) is the missile's place

;; Data definitions for the state of the space invader game:
;; A SIGS is one of:
;; - (make-aim Ufo Tank)
;; - (make-fired Ufo Tank Missile)
;; interpretation represents the complete state of a space invader
;; game

;; Example Descriptions:

;; tank maneuvering into position to fire the missile
(make-aim (make-posn 20 10) (make-tank 28 -3))

;; like the previous but the missile has been fired
(make-fired (make-posn 20 12)
            (make-tank 28 -3)
            (make-posn 28 (- HEIGHT TANK-HEIGHT)))

;; where the missile is about to collide with the UFO
(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))

;; Rendering function says that it maps an element of the
;; state-of-the-world class to class of images
;; SIGS -> Image
;; adds TANK, UFO, and possible MISSILE to
;; the BACKGROUND scene
;; (define (si-render s) BACKGROUND)
