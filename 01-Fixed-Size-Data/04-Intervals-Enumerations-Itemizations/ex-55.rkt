#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-55) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise - 54, 55, 56

(require 2htdp/image)
(require 2htdp/universe)


(define HEIGHT 200) ; distances in pixels
(define WIDTH  100)
(define YDELTA 4)                       ; pixels move per clock tick
(define FCENTER (/ WIDTH 2))

(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET
  (above (triangle 10 "solid" "black")
         (rectangle 5 30 "solid" "red")))

(define CENTER (/ (image-height ROCKET) 2))


(check-expect (show "resting")
              (place-image ROCKET FCENTER (- HEIGHT CENTER) BACKG))
(check-expect (show -2)
              (place-image (text "-2" 20 "red")
                           FCENTER (* 3/4 WIDTH)
                           (place-image ROCKET FCENTER (- HEIGHT CENTER) BACKG)))
(check-expect (show 53)
              (place-image ROCKET FCENTER (- 53 CENTER) BACKG))

(define (draw-rocket y)
  (place-image ROCKET FCENTER y BACKG))

;; LRCD -> Image
(define (show x)
  (cond
    [(string? x)
     (cond
       [(string=? x "resting") 
        (draw-rocket (- HEIGHT CENTER))])]
    [(and (number? x) (<= -3 x -1)) 
     (place-image (text (number->string x) 20 "red")
                  FCENTER (* 3/4 WIDTH)
                  (draw-rocket (- HEIGHT CENTER)))]
    [(and (number? x) (>= x 0)) 
     (draw-rocket (- x CENTER))]))

(define (launch x key)
  (cond
    [(string? x) (if (string=? " " key) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(define (stop x)
  (and (number? x) (= x 0)))

;; LRCD -> LRCD
(define (main1 s)
  (big-bang s
            [to-draw show]
            [on-key launch]))

(define (main2 s)
  (big-bang s
            [to-draw show]
            [on-key launch]
            [on-tick fly 0.5]
            [state #true]
            [stop-when stop]))

;; LRCD -> LRCD
;; raises the rocket by YDELTA if it is moving already
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

;; (main2 "resting") <SPACE>
