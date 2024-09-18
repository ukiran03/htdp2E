#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-77) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct point [hours minutes seconds])

(make-point 3 30 30)
