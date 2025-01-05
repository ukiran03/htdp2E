#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-168) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

; Exercise 168. Design the function translate. It consumes and
; produces lists of Posns. For each (make-posn x y) in the former, the
; latter contains (make-posn x (+ y 1)). We borrow the word
; “translate” from geometry, where the movement of a point by a
; constant distance along a straight line is called a translation

; Lop (list-of-Posns) is one of:
; - '()
; - (cons (make-posn x y) Lop)

; Lop -> Lop
; computes (x y) => (x (add1 y)) for a given Lop and produces new Lop
(define (translate an-lop)
  (cond
    [(empty? an-lop) '()]
    [else (cons (make-posn (posn-x (first an-lop))
                           (add1 (posn-y (first an-lop))))
                (translate (rest an-lop)))]))

(check-expect (translate (cons (make-posn 2 3)
                               (cons (make-posn 3 4) '())))
              (cons (make-posn 2 (add1 3))
                    (cons (make-posn 3 (add1 4)) '())))

(check-expect (translate (cons (make-posn 5 7)
                               (cons (make-posn 2 3)
                                     (cons (make-posn 3 4) '()))))
              (cons (make-posn 5 (add1 7))
                    (cons (make-posn 2 (add1 3))
                          (cons (make-posn 3 (add1 4)) '()))))
