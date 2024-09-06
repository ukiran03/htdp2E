#lang racket

(require 2htdp/image)
;; (< 09 90)
;; (and (or (= (string-length "hello world")
;;             (string->number "11"))
;;          (string=? "hello world" "good morning"))
;;      (>= (+ (string-length "hello world") 60) 80))
;; (above (triangle 40 "solid" "red") (rectangle 40 30 "solid" "black"))

(define victorian
  (above (beside/align "bottom"
                       (triangle 40 "solid" "red")
                       (triangle 30 "solid" "blue"))
         (rectangle 70 40 "solid" "black")))

(define door (rectangle 15 25 "solid" "brown"))

(define door-with-knob
  (overlay/align "right" "center" (circle 3 "solid" "yellow") door))

;; (overlay/align "center" "bottom" door-with-knob victorian)

;; (underlay/align "left" "middle"
;;                   (rectangle 70 70 50 "seagreen")
;;                   (rectangle 60 60 50 "seagreen")
;;                   (rectangle 50 50 50 "seagreen")
;;                   (rectangle 40 40 50 "seagreen")
;;                   (rectangle 30 30 50 "seagreen")
;;                   (rectangle 20 20 50 "seagreen")
;;                   (rectangle 10 10 50 "seagreen"))

(require 2htdp/universe)

(define (a-number digit)
  (overlay
   (text (number->string digit) 12 "black")
   (circle 10 "solid" "white")))
(define (place-and-turn digit dial)
  (rotate 30
          (overlay/align "center" "top"
                         (a-number digit)
                         dial)))

;; `foldl'
(define (place-all-numbers dial)
  (foldl place-and-turn
         dial
         '(0 9 8 7 6 5 4 3 2 1)))

(define UFO
  (underlay/align "center" "center"
                  (circle 10 "solid" "seagreen")
                  (rectangle 40 4 "solid" "seagreen")))
(define (create-UFO-scene height)
  (underlay/xy (rectangle 100 100 "solid" "gray") 50 height UFO))

