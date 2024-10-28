#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-100) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Constants & Data Definitions

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

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

;; State Redering Function
(define (si-render s)
  (cond
    [(aim? s) (tank-render (aim-tank s) (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render (fired-tank s)
                  (missile-render (fired-missile s) (ufo-render (fired-ufo s) BACKGROUND)))]))

;; Ends if one of the two occurs
;; UFO lands on bottom
;; Missile hits UFO
;; writing for fired struct
(check-expect (si-game-over? s0) #true)
(check-expect (si-game-over? s2) #true)
(define (si-game-over? s)
  (cond
    [(and (aim? s) (>= (posn-y (aim-ufo s)) (- HEIGHT (/ UFO-HEIGHT 2)))) #true] ;landed
    [(and (fired? s)
          (or (>= (posn-y (fired-ufo s)) (- HEIGHT (/ UFO-HEIGHT 2))) ;landed
              (collide? (fired-ufo s) (fired-missile s))))
     #true]
    [else #false]))

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
(define (aabb2? p1 p2 p3 p4)
  (and (< (posn-x p1) (posn-x p4)) ;(x1 < x4)
       (> (posn-x p2) (posn-x p3)) ;(x2 > x3)
       (> (posn-y p1) (posn-y p4)) ;(y1 > y4)
       (< (posn-y p2) (posn-y p3)))) ;(y2 < y3)

;; fired-ufo, fired-missile -> collide?
;; interpretation: (collide? ufo missile)
;; check if the Ufo and Missile collide
(define (collide? u m)
  (aabb2? (top-posn (make-posn (posn-x u) (posn-y u)) UFO-HEIGHT UFO-WIDTH)
          (bot-posn (make-posn (posn-x u) (posn-y u)) UFO-HEIGHT UFO-WIDTH)
          (top-posn (make-posn (posn-x m) (posn-y m)) MISSILE-HEIGHT MISSILE-WIDTH)
          (bot-posn (make-posn (posn-x m) (posn-y m)) MISSILE-HEIGHT MISSILE-WIDTH)))

;; si-render-final
;; gameover Image
(define (si-render-final s)
  (overlay (text "Game Over" 32 "indigo") BACKGROUND))

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
(define (move-ufo-x ufo delta)
  (+ (posn-x ufo) (random delta)))

;; Ex-100
;; si-control: plays the role of the key-event handler
(check-expect (si-control s1 "left") (make-aim (make-posn 10 20) (make-tank 25 -3)))
(check-expect (si-control s1 " ")
              (make-fired (make-posn 10 20) (make-tank 28 -3) (make-posn 28 MISSILE-Y)))
(define (si-control s key)
  (cond
    [(aim? s)
     (cond
       [(key=? key " ")
        (make-fired (aim-ufo s) (aim-tank s) (make-posn (tank-loc (aim-tank s)) MISSILE-Y))]
       [else
        (make-aim (aim-ufo s)
                  (make-tank (cond
                               [(key=? key "left") (- (tank-loc (aim-tank s)) 3)]
                               [(key=? key "right") (+ (tank-loc (aim-tank s)) 3)]
                               [else (tank-loc (aim-tank s))])
                             (tank-vel (aim-tank s))))])]
    [(fired? s)
     (make-fired (fired-ufo s)
                 (make-tank (cond
                              [(key=? key "left") (- (tank-loc (fired-tank s)) 3)]
                              [(key=? key "right") (+ (tank-loc (fired-tank s)) 3)]
                              [else (tank-loc (fired-tank s))])
                            (tank-vel (fired-tank s)))
                 (fired-missile s))]))

;; Final "si-game" Game function
(define (si-game s)
  (big-bang s
            [to-draw si-render]
            [on-tick si-move 1]
            [on-key si-control]
            [stop-when si-game-over? si-render-final]))

;; Application
;; (si-game s1)

;; Testing Area
;; few SIGS
(define s0 (make-aim (make-posn 20 196) (make-tank 28 -3))) ; landed
(define s1 (make-aim (make-posn 10 20) (make-tank 28 -3))) ; aimed
(define s2 (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103))) ; hitted
(define s3
  (make-fired (make-posn 10 20) (make-tank 28 -3) (make-posn 32 (- HEIGHT TANK-HEIGHT 10)))) ; fired
;; Rendering Image Structure Functions:
;; tank-render ontop of missile-render ontop of ufo-render
(define (fired-test s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s) (ufo-render (fired-ufo s) BACKGROUND))))
(define (aim-test s)
  (tank-render (aim-tank s) (ufo-render (aim-ufo s) BACKGROUND)))
