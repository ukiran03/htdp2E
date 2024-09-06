#reader(lib "htdp-beginner-reader.ss" "lang")((modname virt-cat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define CAT1 (overlay/align "center" "center" (text "cat-1" 24 "white") (circle 30 "solid" "indigo")))
(define CAT2
  (overlay/align "center" "center" (text "cat-2" 24 "white") (circle 30 "solid" "olivedrab")))
(define WORLD (empty-scene 200 100))
(define VELOCITY 3)
(define Y-CAT (- (image-height WORLD) (/ (image-height CAT1) 2)))
(define (render ws)
  (cond
    [(odd? ws) (place-image CAT1 ws Y-CAT WORLD)]
    [else (place-image CAT2 ws Y-CAT WORLD)]))

(define (restart ws)
  0)

;; WorldState : 0 -> 230 -> 0 -> 230 ...
(define (calc-x ws)
  (modulo (+ VELOCITY ws) (round (+ (image-width WORLD) (/ (image-width CAT1) 2)))))

(define (cat-prog ws)
  (big-bang ws [to-draw render] [on-tick calc-x]))
