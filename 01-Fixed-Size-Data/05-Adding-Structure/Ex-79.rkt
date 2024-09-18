#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; 1)
; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
(define color "white")


;; 2)
;; H is Number between 0 and 100
;; interpretation represents a happiness value
(define H 100)

;; 3)
(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

;; 4)
(define-struct dog [owner name age happiness])
;; A Dog is a structure
;; (make-dog Person String PositiveInteger H)

;; 5)
;; A Weapon is one of:
;; - #false
;; - Posn
;; interpretation #false means the missile hasn't
;; been fired yet; a Posn means it is in flight
(define-struct missile [state pos])
