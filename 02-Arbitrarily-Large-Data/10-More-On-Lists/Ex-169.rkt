#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-169) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

;; Exercise 169. Design the function legal. Like translate from
;; exercise 168, the function consumes and produces a list of Posns.
;; The result contains all those Posns whose x-coordinates are between
;; 0 and 100 and whose y-coordinates are between 0 and 200

; Lop (list-of-Posns) is one of:
; - '()
; - (cons (make-posn x y) Lop)

; Lop -> Number
; returns Lop of legal Posns:
; x => (> x 0) and (< x 100)
; y => (> y 0) and (< y 200)
(define (legal an-lop)
  (cond
    [(empty? an-lop) '()]
    [else
     (if (and
          (> (posn-x (first an-lop)) 0) (< (posn-x (first an-lop)) 100)
          (> (posn-y (first an-lop)) 0) (< (posn-y (first an-lop)) 200))
         (cons (first an-lop)
               (legal (rest an-lop)))
         (legal (rest an-lop)))]))

(check-expect (legal (cons (make-posn 23 17)
                           (cons (make-posn -1 30)
                                 (cons (make-posn 20 -2) '()))))
              (cons (make-posn 23 17) '()))
