#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; A SpaceGame is a structure:
;; (make-space-game Posn Number).
;; interpretation (make-space-game (make-posn ux uy) tx)
;; describes a configuration where the UFO is
;; at (ux, uy) and the tank's x-coordinate is tx

(define-struct space-game [ufo tank])
