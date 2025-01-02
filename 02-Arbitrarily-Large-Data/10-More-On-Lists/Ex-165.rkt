#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-165) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

;; Exercise 165. Design the function subst-robot, which consumes a
;; list of toy descriptions (one-word strings) and replaces all
;; occurrences of "robot" with "r2d2"; all other descriptions remain
;; the same.

;; Generalize subst-robot to substitute. The latter consumes two
;; strings, called new and old, and a list of strings. It produces a
;; new list of strings by substituting all occurrences of old with
;; new.

; List-of-strings -> List-of-strings
; substitutes the word OLD to NEW in the list
(define (subst-robot NEW OLD wlist)
  (cond
    [(empty? wlist) '()]
    [else (cons (if (string=? (first wlist) OLD)
                    NEW
                    (first wlist))
                (subst-robot NEW OLD (rest wlist)))]))

(check-expect (subst-robot "BAT" "bat"
                           (cons "bat" (cons "boy" (cons "bat" (cons "box" '())))))
              (cons "BAT" (cons "boy" (cons "BAT" (cons "box" '())))))
