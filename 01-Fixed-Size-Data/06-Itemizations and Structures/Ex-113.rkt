#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-113) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 113. Design predicates for the following data definitions
;; from the preceding section: SIGS, Coordinate (exercise 105), and
;; VAnimal.

;; -------- SigsOrNot -------
; A UFO is a Posn.
; interpretation:
;; (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
;; A Tank is Structure:
;; (make-tank Number Number)
;; Interpretation: (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn.
; interpretation:
;; (make-posn x y) is the missile's place

; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(check-expect (sigs-or-not? (make-aim (make-posn 2 3) (make-tank 30 10))) #true)
(check-expect (sigs-or-not? (make-fired (make-posn 20 100)
                                        (make-tank 100 3)
                                        (make-posn 22 103))) #true)
(define (sigs-or-not? v)
  (cond
    [(or (aim? v) (fired? v)) #true]
    [else (error "Error")]))

;; -------- CoordinateOrNot -------
; A Coordinate is one of:
; – a NegativeNumber
; interpretation on the y axis, distance from top
; – a PositiveNumber
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define (coordinate-or-not? v)
  (cond
    [(or (number? v) (posn? v)) #true]
    [else (error "Error")]))

;; ------- VAnimal -------
; A VAnimal is either
; – a VCat
; – a VCham

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

(define (vanimal-or-not? v)
  (cond
    [(or (vCat? v) (vCham? v)) #true]
    [else (error "Error")]))
