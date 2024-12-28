#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;; Exercise 153. The goal of this exercise is to visualize the result
;; of a 1968-style European student riot. Here is the rough idea. A
;; small group of students meets to make paint-filled balloons, enters
;; some lecture hall, and randomly throws the balloons at the
;; attendees. Your program displays how the balloons color the seats
;; in the lecture hall.

;; Use the two functions from exercise 152 to create a rectangle of
;; COLUMNS by ROWS squares, each of which has size 10 by 10. Place it
;; in an empty-scene of the same size. This image is your lecture
;; hall.

;; Design add-balloons. The function consumes a list of Posn whose
;; coordinates fit into the dimensions of the lecture hall. It
;; produces an image of the lecture hall with red dots added as
;; specified by the Posns.

;; Figure 60 shows the output of our solution for 10 COLUMNS columns
;; and 20 ROWS when given some list of Posns. The left-most is the
;; clean lecture hall, the second one is after two balloons have hit,
;; and the last one is a highly unlikely distribution of 10 hits.
;; Where is the 10th?

;; Constants
(define COLS 10)
(define ROWS 20)
(define seat (square 10 "outline" "black"))
(define balloon (circle 3 "solid" "red"))

;; Length of Lecture Hall
(define RECT-L (* COLS (image-width seat)))
;; Breadth of Lecture Hall
(define RECT-B (* ROWS (image-width seat)))

;; Functions, Definitions

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

;; makeing the seats of Lecture hall
(define hall (grid COLS ROWS seat))

;; placing seats inside the scene (lecture hall)
(define scene
  (place-image hall
               (/ RECT-L 2) (/ RECT-B 2)
               (empty-scene RECT-L RECT-B)))

;; List of Posns -> Images + Image
;; Interpretation: takes a list of Posns and place there balloons on
;; the scene
(define (add-ballons posns)
  (cond
    [(empty? posns) scene]
    [else (place-image
           balloon
           (posn-x (first posns)) (posn-y (first posns))
           (add-ballons (rest posns)))]))

(define l1-posns (cons (make-posn 20 30) (cons (make-posn 30 10) (cons (make-posn 10 40) '()))))
(define l2-posns '())
(define l3-posns (cons (make-posn 70 30) (cons (make-posn 40 60) (cons (make-posn 50 30) (cons (make-posn 30 60) (cons (make-posn 10 50) '()))))))

;; (add-ballons l1-posns)
;; (add-ballons l2-posns)
;; (add-ballons l3-posns)
