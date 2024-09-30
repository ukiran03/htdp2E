#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

(define MAX-HAPPY 100)
(define MIN-HAPPY 0)
(define WORLD (empty-scene 120 120))
(define BAR-WIDTH 20)
(define BAR-HEIGHT MAX-HAPPY)
(define GAUGE-WIDTH 22)
(define GAUGE-HEIGHT (+ MAX-HAPPY 2))

(define (tock ws)
  (- ws 0.1))

(define (BAR y)
  (rectangle BAR-WIDTH y "solid" "red"))

(define (render ws)
  (place-image (BAR ws) 60 (- 120 (/ ws 2)) WORLD))

;; wrong----
(define (render2 ws)
  (overlay/align/offset "middle"
                        "bottom"
                        (rectangle GAUGE-WIDTH GAUGE-HEIGHT "outline" "balck")
                        0
                        1
                        (place-image (BAR ws) 60 (- 120 (/ ws 2)) WORLD)))

(define (H-up ws)
  (cond
    [(< ws 100) (+ ws (* ws (/ 1.0 3.0)))]
    [else 100]))

(define (just-stop ws)
  (or (negative? ws) (= ws 100)))

(define (H-down ws)
  (cond
    [(< ws 100) (+ ws (* ws (/ 1.0 5.0)))]
    [else 100]))

(define (change ws key)
  (cond
    [(key=? key "up") (H-up ws)]
    [(key=? key "down") (H-down ws)]))

(define (gauge-prog ws)
  (big-bang ws
            [to-draw render]
            [on-tick tock]
            [stop-when just-stop]
            [on-key change]))

