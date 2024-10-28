#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-99) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define UFO-IMG
  (underlay/align/offset "center"
                         "top"
                         (wedge 10 180 "solid" "gray")
                         0
                         9
                         (ellipse 35 15 "solid" "olivedrab")))
(define UFO-SPEED 5)
(define MISSILE-SPEED 5)
(define UFO-DELTA-X 3)
(define UFO-HEIGHT (image-height UFO-IMG))
(define UFO-WIDTH (image-width UFO-IMG))
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
(define TANK-Y (+ (- HEIGHT TANK-HEIGHT) (/ TANK-HEIGHT 2)))
(define MISSILE (ellipse 6 16 "solid" "red"))
(define MISSILE-HEIGHT (image-height MISSILE))
(define MISSILE-WIDTH (image-width MISSILE))

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

;; Ends if one of the two occurs
;; UFO lands on bottom
;; Missile hits UFO
;; writing for fired struct
(define (si-game-over? s)
  (cond
    [(and (aim? s) (= (posn-x (aim-ufo s)) (- HEIGHT (/ UFO-HEIGHT 2)))) 0] ;landed
    [(and (fired? s)
          (or (= (posn-x (fired-ufo s)) (- HEIGHT (/ UFO-HEIGHT 2))) ;landed
              (collide? (fired-ufo s) (fired-missile s))))
     0]))

;; Posn, Height, Width -> Top-Posn of Obj
(check-expect (top-posn (make-posn 20 20) 24 35) (make-posn 2.5 32))
(define (top-posn p h w)
  (make-posn (- (posn-x p) (/ w 2)) (+ (posn-y p) (/ h 2))))

;; Posn, Height, Width -> Bottom-Posn of Obj
(check-expect (bot-posn (make-posn 20 20) 24 35) (make-posn 37.5 8))
(define (bot-posn p h w)
  (make-posn (+ (posn-x p) (/ w 2)) (- (posn-y p) (/ h 2))))

;; Caclculates proximity of two diagonal points
;;(top-left & bottom-right)
;; of two given rectangles(i.e. four points) and output #t of #f
;; interpretation: (aabb? p1 p2 p3 p4)
(check-expect (aabb? (make-posn 1 3) (make-posn 4 1) (make-posn 3 4) (make-posn 6 2)) #false)
(check-expect (aabb? (make-posn 2 3) (make-posn 5 1) (make-posn 4 4) (make-posn 7 2)) #false)
(check-expect (aabb? (make-posn 1 1) (make-posn 3 3) (make-posn 2 2) (make-posn 4 4)) #true)
(check-expect (aabb? (make-posn 2.5 2) (make-posn 37.5 38) (make-posn 17 28) (make-posn 23 12)) #true)
(define (aabb? p1 p2 p3 p4)
  (and (< (posn-x p1) (posn-x p4)) ;(x1 < x4)
       (> (posn-x p2) (posn-x p3)) ;(x2 > x3)
       (< (posn-y p1) (posn-y p4)) ;(y1 < y4)
       (> (posn-y p2) (posn-y p3)))) ;(y2 > y3)

;; fired-ufo, fired-missile -> collide?
;; interpretation: (collide? ufo missile)
;; check if the Ufo and Missile collide
(define (collide? u m)
  (aabb? (top-posn (make-posn (posn-x u) (posn-y u)) UFO-HEIGHT UFO-WIDTH)
         (bot-posn (make-posn (posn-x u) (posn-y u)) UFO-HEIGHT UFO-WIDTH)
         (top-posn (make-posn (posn-x m) (posn-y m)) MISSILE-HEIGHT MISSILE-WIDTH)
         (bot-posn (make-posn (posn-x m) (posn-y m)) MISSILE-HEIGHT MISSILE-WIDTH)))

;; si-render-final
(define si-render-final (overlay (text "Game Over" 32 "indigo") BACKGROUND))

;; si-move: consumes an element of SIGS and produces another one,
;; this function called for every clock tick
;; (define (si-move s))

;; Ex-99
;; Produce next frame of given UFO
;; UFO reaches to the bottom of the SCENE
;; interpretation: (si-move SIGS)
(check-random (si-move s1)
              (make-aim (make-posn (+ 10 (random UFO-DELTA-X)) (+ 20 UFO-SPEED)) (make-tank 28 -3)))
(check-random (si-move s2)
              (make-fired (make-posn (+ 20 (random UFO-DELTA-X)) (+ 100 UFO-SPEED))
                          (make-tank 100 3)
                          (make-posn 22 (- 103 MISSILE-SPEED))))
(define (si-move s)
  (cond
    [(aim? s) (make-aim (ufo-nframe (aim-ufo s)) (aim-tank s))]
    [(fired? s)
     (make-fired (ufo-nframe (fired-ufo s)) (fired-tank s) (missile-nframe (fired-missile s)))]))

;; Ufo reaches bottom
(define (ufo-nframe ufo)
  (make-posn (move-ufo-x ufo UFO-DELTA-X) (+ (posn-y ufo) UFO-SPEED)))

;; Missile reaches top
(define (missile-nframe mis)
  (make-posn (posn-x mis) (- (posn-y mis) MISSILE-SPEED)))

;; UFO Number -> Number
;; prooduces a number in the interval [0,n)
;; possibly a different one each time it is called
; moves the space-invader objects UFO predictably by delta
(define (move-ufo-x ufo delta)
  (+ (posn-x ufo) (random delta)))

;; Testing Area
;; ------------
;; few SIGS
(define s1 (make-aim (make-posn 10 20) (make-tank 28 -3)))
(define s2 (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))
(define s3 (make-fired (make-posn 10 20) (make-tank 28 -3) (make-posn 32 (- HEIGHT TANK-HEIGHT 10))))
;; Rendering Image Structure Functions:
;; tank-render ontop of missile-render ontop of ufo-render
(define (fired-test s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s) (ufo-render (fired-ufo s) BACKGROUND))))
(define (aim-test s)
  (tank-render (aim-tank s) (ufo-render (aim-ufo s) BACKGROUND)))
