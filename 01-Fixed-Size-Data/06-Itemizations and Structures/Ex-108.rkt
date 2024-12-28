#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-108) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 108. In its default state, a pedestrian crossing light
;; shows an orange person standing, on a black background. When it is
;; time to allow the pedestrian to cross the street, the light
;; receives a signal and switches to a green, walking person. This
;; phase lasts for 10 seconds. After that the light displays the
;; digits 9, 8, ..., 0 with odd numbers colored orange and even
;; numbers colored green. When the countdown reaches 0, the light
;; switches back to its default state.

;;; Data Definitions and Constants:

(define STOP 0)
(define WALK 1)
(define TIMER 2)

;; A Light is one of:
;; - Stop
;; - Walk
;; - Timer
;; Represents the state of the traffic light

;; A Timer is one of:
;; - Number
;; - #false
;; Represents a number of seconds
;; before switching to the next traffic light

(define-struct tl [light timer])
;; A TL (Traffic Light) is a structure:
;; (make-tl Light Timer)
;; (make-tl l t) represents a traffic light with
;; the light l enabled and
;; the number of seconds t till the next traffic light state switch

;; A KeyEvent is a " "
;; Represents a pressed space key

;;; Constants

(define BOARD (overlay (rectangle 68 56 "solid" "black") (empty-scene 74 62 "gray")))
(define REDPIC (bitmap "../.././images/pedestrian_traffic_light_red.png"))
(define GREENPIC (bitmap "../.././images/pedestrian_traffic_light_green.png"))

(define TIMER-MAX 10)                   ; seconds
(define ODD-COLOR "orange")
(define EVEN-COLOR "green")

(define (render tls)
  (overlay
   (cond
     [(= STOP (tl-light tls)) REDPIC]
     [(= WALK (tl-light tls)) GREENPIC]
     [(= TIMER (tl-light tls))
      (text (number->string (- (tl-timer tls) 1))
            30
            (if (even? (- (tl-timer tls) 1)) EVEN-COLOR ODD-COLOR))])
   BOARD))

(define (tick-handler tls)
  (if (= STOP (tl-light tls))
      tls
      (cond
        [(> (tl-timer tls) 1)
         (make-tl (tl-light tls) (- (tl-timer tls) 1))]
        [(= WALK (tl-light tls))
         (make-tl TIMER TIMER-MAX)]
        [(= TIMER (tl-light tls))
         (make-tl STOP #false)])))

(define (key-handler tls key)
  (if (and (= (tl-light tls) STOP) (key=? key " "))
      (make-tl WALK TIMER-MAX)
      tls))

(define (traffic-light tls)
  (big-bang tls
            [to-draw render]
            [on-tick tick-handler 1]
            [on-key key-handler]))

(define test0 (make-tl STOP 6))
(define test1 (make-tl WALK 6))
(define test2 (make-tl TIMER 6))
