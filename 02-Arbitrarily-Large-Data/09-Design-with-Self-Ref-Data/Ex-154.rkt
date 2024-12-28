#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-154) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of:
; - String
; - (make-layer String RD)

;; Exercise 154. Design the function colors. It consumes a Russian
;; doll and produces a string of all colors, separated by a comma and
;; a space.

; RD -> Strings (Colors)
;; Return the all Strings(colors) of the given Russian Doll

(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (string-append (layer-color an-rd)
                         ", "
                         (colors (layer-doll an-rd)))]))

(check-expect
 (colors (make-layer "yellow" (make-layer "green" "red")))
 "yellow, green, red")
(check-expect (colors "red") "red")
