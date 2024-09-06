#lang racket

(require htdp/image)

;; ex-16
(define (image-area image)
  (* (image-width image) (image-height image)))
