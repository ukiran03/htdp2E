#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-155) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of:
; - String
; - (make-layer String RD)

;; Exercise 155. Design the function inner, which consumes an RD and
;; produces the (color of the) innermost doll. Use DrRacket’s stepper
;; to evaluate (inner rd) for your favorite rd.

; RD -> String (color)
;; Produces the Color of innermost Doll of the given RD
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (inner (layer-doll an-rd))]))

(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) "red")
(check-expect (inner "red") "red")
