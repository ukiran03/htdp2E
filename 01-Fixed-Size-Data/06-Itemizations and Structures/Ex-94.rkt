#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 94. Draw some sketches of what the game scenery looks like
;; at various stages. Use the sketches to determine the constant and
;; the variable pieces of the game. For the former, develop physical
;; and graphical constants that describe the dimensions of the world
;; (canvas) and its objects. Also develop some background scenery.
;; Finally, create your initial scene from the constants for the tank,
;; the UFO, and the background.

;; Create your initial scene
;; from the constants for the tank, the UFO, and the background.

;; Constants

(define WIDTH 300)
(define HEIGHT 450)
(define SCENE (empty-scene WIDTH HEIGHT))

(define UFO (underlay/align/offset
             "center" "top" (wedge 10 180 "solid" "gray")
             0 9 (ellipse 35 15 "solid" "olivedrab")))
(define UFO2 (underlay/align/offset
             "center" "top" (wedge 10 180 "solid" "olivedrab")
             0 9 (ellipse 35 15 "solid" "gray")))
(define UFO-HEIGHT (image-height UFO))
(define UFO-X-START (/ WIDTH 2))
(define UFO-Y-START (/ UFO-HEIGHT 2))

(define TANK (overlay/align/offset
              "center" "top" (rectangle 5 15 "solid" "black")
              0 9 (overlay/align
                   "center" "center" (circle 9 "solid" "black")
                   (rectangle 30 25 "solid" "yellowgreen"))))
(define TANK-HEIGHT (image-height TANK))
(define TANK-WIDTH (image-width TANK))
(define TANK-X-START (/ TANK-WIDTH 2))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))

(define MISSILE (ellipse 6 16 "solid" "red"))


;;; Application

(place-image UFO
             UFO-X-START UFO-Y-START
             (place-image TANK
                          TANK-X-START TANK-Y
                          SCENE))
