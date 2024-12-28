#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.2-dolls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of:
; - String
; - (make-layer String RD)


; RD -> Number
; how many dolls are part of an-rd
(check-expect (depth (make-layer "pink" (make-layer "black" "white"))) 3)
(check-expect (depth "red") 1)

(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [else (add1 (depth (layer-doll an-rd)))]))
