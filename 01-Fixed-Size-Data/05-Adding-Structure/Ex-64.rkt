#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-64) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define (manhattan-dist ap)
  (+ (abs (posn-x ap)) (abs (posn-y ap))))
