#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 12 h))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs))
                (wage* (rest whrs)))]))
