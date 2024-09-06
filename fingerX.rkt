#reader(lib "htdp-beginner-reader.ss" "lang")((modname fingerX) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define (string-first str)
  (string-ith str 0))

(define (string-last str)
  (string-ith str
              (- (string-length str) 1)))

;; (define (myimage l)
;;   (square l "solid" "red"))
;; (define (image-area img)
;;   (* (image-width img)
;;      (image-height img)))

(define (string-rest str)
  (substring str 1 (string-length str)))

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
