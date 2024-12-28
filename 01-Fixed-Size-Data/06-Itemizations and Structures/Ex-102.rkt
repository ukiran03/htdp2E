#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-101) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Constants and Data Definitions

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT "deepskyblue"))

(define UFO-DELTA-X 3)
(define UFO-SPEED 5)
(define UFO-HEIGHT 10)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO-IMG
  (overlay (circle (/ UFO-HEIGHT 2) "solid" "palegreen")
           (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))

(define TANK-HEIGHT 8)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "midnightblue"))

(define MISSILE-SPEED 5)
(define MISSILE (ellipse 6 16 "solid" "red"))
(define MISSILE-HEIGHT (image-height MISSILE))
(define MISSILE-WIDTH (image-width MISSILE))
(define MISSILE-Y (+ TANK-Y (/ MISSILE-HEIGHT 2)))

;; Structures

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

(define-struct sigs [ufo tank missile])
;; A SIG.v2 is a Structure:
;; (make-sigs UFO Tank MissileOrNot)
;; interpertation represents the complete state of a space invader
;; game

;; A MissileOrNot is one of:
;; - #false
;; - Posn
;; Interpretation:
;; #false means the missile is in the tank;
;; Posn says the missile is at the location

;; Tank Image -> Image
;; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (+ (tank-loc t) (tank-vel t)) TANK-Y im))

;; UFO Image -> Image
;; adds u to the given image im
;; (define (ufo-render u im) im)
(define (ufo-render u im)
  (place-image UFO-IMG (posn-x u) (posn-y u) im))

;; MissileOrNot Image -> Image
;; adds an image of missile m to scene s
;; (check-expect (missile-render.v2 ))
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (place-image MISSILE (posn-x m)
                            (posn-y m) s)]))

;; State Rendering Function
(define (si-render-v2 s)
  (tank-render (sigs-tank s)
               (missile-render.v2 (sigs-missile s)
                                  (ufo-render (sigs-ufo s) BACKGROUND))))

;; Game Ends if one of the two occurs
;; UFO lands on bottom
;; Missile hits UFO
;; writing for fired struct
(check-expect (si-game-over-v2? s0) #true)
(check-expect (si-game-over-v2? s2) #true)
(define (si-game-over-v2? s)
  (cond
    [(or
      (>= (posn-y (sigs-ufo s)) (- HEIGHT (/ UFO-HEIGHT 2)))
      (and (posn? (sigs-missile s))
           (collide? (sigs-ufo s) (sigs-missile s)))) #true]
    [else #false]))

;; Collision Detection by checking the Proximity of the UFO and
;; Missile by using AABB method

(check-expect (top-posn (make-posn 20 20) 24 35) (make-posn 2.5 32))
(define (top-posn p h w)
  (make-posn (- (posn-x p) (/ w 2)) (+ (posn-y p) (/ h 2))))
(check-expect (bot-posn (make-posn 20 20) 24 35) (make-posn 37.5 8))
(define (bot-posn p h w)
  (make-posn (+ (posn-x p) (/ w 2)) (- (posn-y p) (/ h 2))))
;; Proximity check
(define (aabb2? p1 p2 p3 p4)
  (and (< (posn-x p1) (posn-x p4)) ;(x1 < x4)
       (> (posn-x p2) (posn-x p3)) ;(x2 > x3)
       (> (posn-y p1) (posn-y p4)) ;(y1 > y4)
       (< (posn-y p2) (posn-y p3)))) ;(y2 < y3)

(define (collide? u m)
  (aabb2? (top-posn (make-posn (posn-x u) (posn-y u)) UFO-HEIGHT UFO-WIDTH)
          (bot-posn (make-posn (posn-x u) (posn-y u)) UFO-HEIGHT UFO-WIDTH)
          (top-posn (make-posn (posn-x m) (posn-y m)) MISSILE-HEIGHT MISSILE-WIDTH)
          (bot-posn (make-posn (posn-x m) (posn-y m)) MISSILE-HEIGHT MISSILE-WIDTH)))

;; si-render-final
;; gameover Image
(define (si-render-final s)
  (overlay (text "Game Over" 32 "indigo") BACKGROUND))

;; Produce next frame of the Objects on the scene
;; interpretation: (si-move-v2 SIGS)
(check-random (si-move-v2 s1)
              (make-sigs (make-posn (+ 10 (random UFO-DELTA-X)) (+ 20 UFO-SPEED)) (make-tank 28 -3) #false))
(check-random (si-move-v2 s2)
              (make-sigs (make-posn (+ 20 (random UFO-DELTA-X)) (+ 100 UFO-SPEED))
                         (make-tank 100 3)
                         (make-posn 22 (- 103 MISSILE-SPEED))))
(define (si-move-v2 s)
    (make-sigs (ufo-nframe (sigs-ufo s))
               (sigs-tank s)
               (cond
                 [(boolean? (sigs-missile s)) (sigs-missile s)]
                 [(posn? (sigs-missile s)) (missile-nframe (sigs-missile s))])))

;; Ufo reaching bottom
(define (ufo-nframe ufo)
  (make-posn (move-ufo-x ufo UFO-DELTA-X) (+ (posn-y ufo) UFO-SPEED)))
;; UFO Number -> Number
;; prooduces a number in the interval [0,n)
(define (move-ufo-x ufo delta)
  (+ (posn-x ufo) (random delta)))

;; Missile reaching top
(define (missile-nframe mis)
  (make-posn (posn-x mis) (- (posn-y mis) MISSILE-SPEED)))

;; si-control-v2: plays the role of the key-event handler
(check-expect (si-control-v2 s1 "left") (make-sigs (make-posn 10 20) (make-tank 25 -3) #false))
(check-expect (si-control-v2 s1 " ")
              (make-sigs (make-posn 10 20) (make-tank 28 -3) (make-posn 28 MISSILE-Y)))
(define (si-control-v2 s key)
  (make-sigs (sigs-ufo s)
             (make-tank (cond
                          [(key=? key "left") (- (tank-loc (sigs-tank s)) 3)]
                          [(key=? key "right") (+ (tank-loc (sigs-tank s)) 3)]
                          [else (tank-loc (sigs-tank s))])
                        (tank-vel (sigs-tank s)))
             (if (and (key=? key " ") (boolean? (sigs-missile s)))
                 (make-posn (tank-loc (sigs-tank s)) MISSILE-Y)
                 (sigs-missile s))))

;; Final "si-game" Game function
(define (si-game-v2 s)
  (big-bang s
            [to-draw si-render-v2]
            [on-tick si-move-v2 1]
            [on-key si-control-v2]
            [stop-when si-game-over-v2? si-render-final]))

;; Application
;; (si-game s1)

;; Testing Area
(define m1 #false)
(define m2 (make-posn 32 (- HEIGHT TANK-HEIGHT 10)))

(define s0 (make-sigs (make-posn 20 196) (make-tank 28 -3) #false)) ; landed
(define s1 (make-sigs (make-posn 10 20) (make-tank 28 -3) #false)) ; aimed
(define s2 (make-sigs (make-posn 20 100) (make-tank 100 3) (make-posn 22 103))) ; hitted
(define s3
  (make-sigs (make-posn 10 20) (make-tank 28 -3) (make-posn 32 (- HEIGHT TANK-HEIGHT 10)))) ; fired
