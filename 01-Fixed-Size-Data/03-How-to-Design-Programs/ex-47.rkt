#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

(define MAX-HAPPY 100)
(define MIN-HAPPY 0)
(define SCORE-DECREASE 0.1)
(define SCORE-INCREASE 5)               ; adds 1/5 of ws
(define SCORE-BOOST 3)                  ; adds 1/3 of ws

(define GAUGE-WIDTH (/ MAX-HAPPY 10))
(define GAUGE-HEIGHT MAX-HAPPY)         ; On Max Happiness

(define FRAME-WIDTH (+ GAUGE-WIDTH 3))
(define FRAME-HEIGHT GAUGE-HEIGHT)

(define SCENE-WIDTH (* FRAME-WIDTH 4))
(define SCENE-HEIGHT (+ FRAME-HEIGHT 1))

(define SCENE
  (empty-scene SCENE-WIDTH SCENE-HEIGHT))
(define FRAME
  (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black"))

(define (render ws)
  (if (> ws MAX-HAPPY)
      (draw-guage MAX-HAPPY)
      (draw-guage ws)))

(define (draw-guage height)
  (overlay/align/offset
   "middle" "bottom"
   (rectangle GAUGE-WIDTH height "solid" "red")
   0 1
   (overlay/align/offset
    "middle" "bottom"
    FRAME
    0 1
    SCENE)))

(define (draw-guage-horz width)         ; Example
  (overlay/align/offset
   "left" "middle"
   (rectangle 103 13 "outline" "black")
   1 0
   (rectangle width (/ MAX-HAPPY 10) "solid" "red")))

;; WorldState -> Boolean
(define (end? ws)
  (= ws 0))

;; WorldState -> WorldState
(define (tick-handler ws)
  (cond
    [(> ws MAX-HAPPY) MAX-HAPPY]
    [(<= ws SCORE-DECREASE) MIN-HAPPY]
    [else (- ws SCORE-DECREASE)]))

;; WorldState -> WorldState
(define (key-handler ws key)
  (cond
    [(key=? key "up") (increase-score ws SCORE-BOOST)]
    [(key=? key "down") (increase-score ws SCORE-INCREASE)]))

(define (increase-score ws addby)
  (if (> (+ (/ ws addby) ws) MAX-HAPPY)
      MAX-HAPPY
      (+ (/ ws addby) ws)))

(define (gauge-prog ws)
  (big-bang ws
            [to-draw render]
            [on-tick tick-handler]
            [stop-when end?]
            [on-key key-handler]))

;; Run
(gauge-prog 50)

