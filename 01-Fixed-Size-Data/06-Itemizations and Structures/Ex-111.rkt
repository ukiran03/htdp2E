#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-111) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(define (checked-make-vec x y)
  (cond
    [(and (positive? x) (positive? y))
     (make-vec x y)]
    [else (error "Vec(x, y): Positive numbers expected")]))
