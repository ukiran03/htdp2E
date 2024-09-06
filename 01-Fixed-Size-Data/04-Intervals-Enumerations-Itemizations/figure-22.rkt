#reader(lib "htdp-beginner-reader.ss" "lang")((modname figure-22) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Sample Problem Design a program that simulates the descent of a UFO
;; Data Definitions

;; A WorldState is a Number.
;; Represents the number of pixels between the top and the UFO.
;; Falls into one of three intervals:
;; – between 0 and CLOSE
;; – between CLOSE and BOTTOM
;; – below BOTTOM

;; Constants
(define WIDTH 200)                      ;distances in terms of pixels
(define HEIGHT 300)
(define UFO (overlay/align/offset
             "center" "top" (wedge 15 180 "solid" "gray")
             0 12
             (overlay/align "center" "top"
                            (ellipse 50 15 "solid" "yellowgreen")
                            (ellipse 70 30 "solid" "olivedrab"))))
(define CLOSE (/ HEIGHT 3))
(define BOTTOM (- HEIGHT (/ (image-height UFO) 2))) ;Landing place
(define MTSCN (empty-scene WIDTH HEIGHT))
(define MSG-BOX (rectangle WIDTH 17 "solid" "gray"))
(define FONT-SIZE 12)

;; WorldState -> Boolean
(check-expect (end? BOTTOM) #false)
(check-expect (end? (- BOTTOM 1)) #false)
(check-expect (end? (+ BOTTOM 1)) #true)
(define (end? pos)
  (> pos BOTTOM))

;; WorldState -> Image (Message)
(check-expect (render/status 10) (text "Descending" FONT-SIZE "green"))
(define (render/status y)
  (cond
    [(>= y BOTTOM)
     (text "Landed" FONT-SIZE "red")]
    [(<= 0 y CLOSE)
     (text "Descending" FONT-SIZE "green")]
    [(< CLOSE y BOTTOM)
     (text "Closing in" FONT-SIZE "orange")]))

;; WorldState -> Image (UFO)
(define (render-ufo pos)
  (place-image UFO (/ WIDTH 2) pos MTSCN))

;; WorldState -> Image (Status)
(define (render-status pos)
  (overlay/align "center" "center"
                 (render/status pos)
                 MSG-BOX))
;; WorldState -> Image (Scene)
(define (render-scene pos)
  (above (render-ufo pos)
         (render-status pos)))

;; Worldstate -> Worldstate
(check-expect (nxt 3) 6)
(define (nxt pos)
  (+ pos 3))

;; Worldstate -> Worldstate
(define (descend-ufo pos)
  (big-bang pos
            [on-tick nxt]
            [on-draw render-scene]
            [stop-when end?]))
