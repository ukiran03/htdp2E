#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Exercise 142. Design the ill-sized? function, which consumes a list
;; of images loi and a positive number n. It produces the first image
;; on loi that is not an n by n square; if it cannot find such an
;; image, it produces #false.


; List-of-images -> Image

(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(cons? loi) (ImageOrFalse (first loi) n)]
    [else #false]))

; ImageOrFalse is one of:
; – Image
; – #false
(define (ImageOrFalse img n)
  (if (and (image? img) (positive? n)
           (= (* (image-width img) (image-height img)) (* n n)))
      img #false))

(define (Yil n)
  (cons (square n "solid" "slateblue")
        (cons (circle (+ n 5) "outline" "red")
              (cons (rectangle n n "outline" "black") '()))))

(define (Nil n)
  (cons (square n "solid" "slateblue")
        (cons (circle n "outline" "red")
              (cons (rectangle n n "outline" "black") '()))))



;; (define 10i
;;   (cons (square 10 "solid" "slateblue")
;;         (cons (circle 20 "outline" "red")
;;               (cons (rectangle 10 10 "outline" "black") '()))))

;; (define 15i
;;   (cons (square 15 "solid" "slateblue")
;;         (cons (circle 20 "outline" "red")
;;               (cons (rectangle 15 15 "outline" "black") '()))))

;; (define 20i
;;   (cons (square 20 "solid" "slateblue")
;;         (cons (circle 10 "outline" "red")
;;               (cons (rectangle 20 20 "outline" "black") '()))))
