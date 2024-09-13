#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket-re) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)



(define HEIGHT 200) ; distances in pixels
(define WIDTH  100)
(define YDELTA 3)

(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))

(define CENTER (/ (image-height ROCKET) 2))


(check-expect (show "resting")
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect (show -2)
              (place-image (text "-2" 20 "red")
                           10 (* 3/4 WIDTH)
                           (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))
(check-expect (show 53)
              (place-image ROCKET 10 (- 53 CENTER) BACKG))

;; (define (show x)
;;   (cond
;;     [(string? x) (cond
;;                    [(string=? x "resting")] (place-image ROCKET 10 HEIGHT BACKG))]
;;     [(<= -3 x -1) (place-image (text x 20 "red")
;;                                10 (* 3/4 WIDTH)
;;                                (place-image ROCKET 10 HEIGHT BACKG))]
;;     [(>= x 0) (place-image ROCKET 10 x BACKG)] ))

(define (show x)
  (cond
    [(string? x)
     (cond
       [(string=? x "resting") 
        (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)])]
    [(and (number? x) (<= -3 x -1)) 
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))]
    [(and (number? x) (>= x 0)) 
     (place-image ROCKET 10 (- x CENTER) BACKG)]))
