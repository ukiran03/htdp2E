#reader(lib "htdp-beginner-reader.ss" "lang")((modname sample2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(require 2htdp/image)
(require 2htdp/universe)

;; ; WorldState: data that represents the state of the world (cw)
;;
;; ; WorldState -> Image
;; ; when needed, big-bang obtains the image of the current
;; ; state of the world by evaluating (reder cw)
;; (define (render ws)
;;   ...)
;; ; WorldState -> WorldState
;; ; for each tick of the clock, big-bang obtains the next
;; ; state of the world from (clock-tick-handler cw)
;; (define (clock-tick-handler cw)
;;   ...)
;; ; WorldState String -> WorldState
;; ; for each keystroke, big-bang obtains the next state
;; ; from (keystroke-handler cw ke); ke represents the key
;; (define (keystroke-handler cw ke)
;;   ...)
;; ; WorldState Number Number String -> WorldState
;; ; for each mouse gesture, big-bang obtains the next state
;; ; from (mouse-event-handler cw x y me) where x and y are
;; ; the coordinates of the event and me is its description
;; (define (mouse-event-handler cw x y me)
;;   ...)
;; ; WorldState -> Boolean
;; ; after each event, big-bang evaluates (end? cw)
;; (define (end? cw)
;;   ...)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CAR-B
  (rectangle (+ (image-width BOTH-WHEELS) (* 2 WHEEL-RADIUS)) (* 2 WHEEL-RADIUS) "solid" "red"))
(define MIRRORS
  (beside (rectangle 7 7 "solid" "gray")
          (rectangle 5 5 "solid" "red")
          (rectangle 7 7 "solid" "gray")))
(define CAR-T (underlay (rectangle WHEEL-DISTANCE (* 2 WHEEL-RADIUS) "solid" "red") MIRRORS))

(define CAR (above CAR-T CAR-B BOTH-WHEELS))

(define my-tree
  (overlay/offset
   (overlay/offset
    (overlay/offset (circle 10 "solid" "olivedrab") 10 0 (circle 10 "solid" "olivedrab"))
    0
    -10
    (circle 10 "solid" "olivedrab"))
   0
   20
   (rectangle 10 20 "solid" "brown")))

(define (tock ws)
  (+ ws 3))

(define MT-BG (empty-scene 300 100))
(define BACKGROUND (place-image my-tree 250 75 MT-BG))

;; (define Y-CAR (- (image-height MT-BG) 17))

;; (define (render ws)
;;   (place-image CAR ws Y-CAR BACKGROUND))

(define (stop y ke)
  0)
(define (add3 y)
  (+ y 3))
;; (define (main y)
;;   (big-bang y
;;             [on-tick add3]
;;             ;; [stop-when 270]
;;             [to-draw render]
;;             [on-key stop]))

(define BIG-BG (place-image (text "Hello\n Sin wave" 24 "orange") 140 50 BACKGROUND))

(define (render ws)
  (place-image CAR ws (+ 83 (sin ws)) BIG-BG))
(define (main y)
  (big-bang y [on-tick add1] [to-draw render] [on-key stop]))

;; run (main 0)
