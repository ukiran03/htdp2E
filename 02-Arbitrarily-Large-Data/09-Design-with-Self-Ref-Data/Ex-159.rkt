#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-159) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 159. Turn the solution of exercise 153 into a world
;; program. Its main function, dubbed riot, consumes how many balloons
;; the students want to throw; its visualization shows one balloon
;; dropping after another at a rate of one per second. The function
;; produces the list of Posns where the balloons hit.

;; Constants
(define COLS 10)
(define ROWS 20)
(define seat (square 10 "outline" "black"))
(define balloon (circle 3 "solid" "red"))
(define HEIGHT (* ROWS (image-width seat)))
(define WIDTH (* COLS (image-width seat)))

;; Functions, Definitions
(define-struct pair [num posns])
; A Pair is a structure (make-pair num posns)
; A List-of-posns is one of:
; - '()
; - (cons Posn List-of-posns)
; interpretation (make-pair num posns) means n balloons
; must yet be thrown and added to lob

; m, n -> Number
; img -> Image
;; produces a column of n images(img)
(define (col n img)
  (cond
    [(< n 2) img]
    [else (above img (col (sub1 n) img))]))

;; produces a column of n images(img)
(define (row n img)
  (cond
    [(< n 2) img]
    [else (beside img (row (sub1 n) img))]))

; computes a grid of mxn of the image(img)
(define (grid m n img)
  (cond
    [(< n 2) (row m img)]
    [else (above (row m img)
                 (grid m (sub1 n) img))]))

;; placing seats inside the scene (lecture hall)
(define lec-hall
  (place-image (grid COLS ROWS seat)
               (/ WIDTH 2) (/ HEIGHT 2)
               (empty-scene WIDTH HEIGHT)))

;; List of Posns -> Images + Image
;; Interpretation: takes a list of Posns and place there balloons on
;; the scene
(define (add-ballons posns)
  (cond
    [(empty? posns) lec-hall]
    [else (place-image
           balloon
           (posn-x (first posns)) (posn-y (first posns))
           (add-ballons (rest posns)))]))

; List-of-posns -> List-of-posns
; Adds a Balloon to the List-of-posns
(define (mk-balloons lp)
  (cons (make-posn (random WIDTH) (random HEIGHT))
        lp))

;; To-image
; List-of-posns -> Image
(define (to-image p)
  (add-ballons (pair-posns p)))

;; Tock
;Pair -> Pair
(check-expect (tock (make-pair 0 '())) (make-pair 0 '()))
(check-expect (tock (make-pair 0 (cons (make-posn 5 10) '())))
              (make-pair 0 (cons (make-posn 5 10) '())))
(check-random (tock (make-pair 1 '()))
              (make-pair 0 (cons (make-posn (random WIDTH) (random HEIGHT)) '())))
(check-random (tock (make-pair 2 (cons (make-posn 5 10) '())))
              (make-pair 1 (cons
                            (make-posn (random WIDTH) (random HEIGHT))
                            (cons (make-posn 5 10) '()))))

(define (tock p)
  (cond
    [(zero? (pair-num p)) p]
    [else (make-pair (sub1 (pair-num p))
                     (mk-balloons (pair-posns p)))]))

;; Number -> Pair
;; Launches the world program with N baloons.
;; Usage: (riot 10)
(define (riot n)
  (main (make-pair n '())))

;; Pair -> Pair
;; Produces the world program.
(define (main w0)
  (big-bang w0
            [to-draw to-image]
            [on-tick tock 1]))


; --- testing area
(define l1-posns (cons (make-posn 20 30) (cons (make-posn 30 10) (cons (make-posn 10 40) '()))))
(define l2-posns '())
(define l3-posns (cons (make-posn 70 30) (cons (make-posn 40 60) (cons (make-posn 50 30) (cons (make-posn 30 60) (cons (make-posn 10 50) '()))))))
