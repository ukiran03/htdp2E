#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-88) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; A Structure type that keeps track of the cat's x-coordinate
;; and its happiness

;; A Score is a Number in an interval [0, 100]
;; Represents a happiness level

(define-struct vCat [x score])
;; A VCat is a structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s
