#lang racket

(require 2htdp/image)

(define tree
  (overlay/offset (overlay/offset
                  (overlay/offset (circle 20 "solid" "olivedrab")
                                  20 0
                                  (circle 20 "solid" "olivedrab"))
                  0 -20
                  (circle 20 "solid" "olivedrab"))
                 0 40
                 (rectangle 15 45 "solid" "brown")))

(underlay (ellipse 10 60 40 "red")
            (ellipse 20 50 40 "red")
            (ellipse 30 40 40 "red")
            (ellipse 40 30 40 "red")
            (ellipse 50 20 40 "red")
            (ellipse 60 10 40 "red"))
