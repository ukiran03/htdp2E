#lang racket

(require 2htdp/image)
(require 2htdp/universe)
;; properties of the "world" and the descending rocket
(define HEIGHT 150)
(define WIDTH 100)
(define V 3)
(define X 50)
(define (distance t)
  (* V t))

; graphical constants
(define MTSCN (empty-scene WIDTH HEIGHT))

(define ROCKET .)
(define ROCKET-CENTER-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

; functions
(define (move-rocket-v3 t)
  (cond
    [ (<= (distance t) ROCKET-CENTER-TOP)
      (place-image ROCKET X (distance t) MTSCN) ]
    [ (> (distance t) ROCKET-CENTER-TOP)
      (place-image ROCKET X ROCKET-CENTER-TOP MTSCN) ]))


