#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-152) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;; Exercise 152. Design two functions: col and row. The function col
;; consumes a natural number n and an image img. It produces a
;; column—a vertical arrangement—of n copies of img. The function row
;; consumes a natural number n and an image img. It produces a row—a
;; horizontal arrangement—of n copies of img.

; n -> Number
; img -> Image
;; produces a column of n images(i)

(define (col n img)
  (cond
    [(< n 2) img]
    [else (above img (col (sub1 n) img))]))

; n -> Number
; img -> Image
;; produces a column of n images(i)

(define (row n img)
  (cond
    [(< n 2) img]
    [else (beside img (row (sub1 n) img))]))

;; ----- Fun

; m, n -> Numbers
; img -> Image
; computes a grid of mxn of the image(i)

(define (grid m n img)
  (cond
    [(< n 2) (row m img)]
    [else (above (row m img)
                 (grid m (sub1 n) img))]))
