#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ;; For
;; ;; DrRacket

;; ; List-of-string String -> N
;; ; determines how often s occurs in los
(define (count los s)
  (cond
    [(empty? los) 0]
    [(string=? s (first los)) (add1 (count (rest los) s))]
    [else (count (rest los) s)]))

;; (count
;;  (cons "apple" (cons "banana" (cons "apple" (cons "orange" (cons "apple" '()))))) "apple")

; If the list is empty, return 0
; Match found, increment the count
; No match, continue with the rest of the list

; Son
(define es '())

; ---

; Number Son.L -> Son.L
; removes x from s
(define s1.L
  (cons 1 (cons 1 '())))

(check-expect
 (set-.L 1 s1.L) es)

(define (set-.L x s)
  (remove-all x s))

; ---

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))

(check-expect
 (set-.R 1 s1.R) es)

(define (set-.R x s)
  (remove x s))

;; Exercise 160: Design the functions set+.L and set+.R, which create a
;; set by adding a number x to some given set s for the left-hand and
;; right-hand data definition, respectively.

;; A Set-of-numbers-L is one of:
;; – empty
;; – (cons Number Set-of-numbers-L)
;; May contain not unique numbers.

;; A Set-of-numbers-R is one of:
;; – empty
;; – (cons Number Set-of-numbers-R)
;; Contains only unique numbers.


;; Set-of-numbers-L -> Set-of-numbers-L
;; Adds a number x to the given set s.
(check-expect (set+.L '() 1) (cons 1 '()))
(check-expect (set+.L (cons 1 '()) 1) (cons 1 (cons 1 '())))
(define (set+.L s x)
  (cons x s))

;; Set-of-numbers-R -> Set-of-numbers-R
;; Adds a number x to the given set s.
(check-expect (set+.R '() 1) (cons 1 '()))
(check-expect (set+.R (cons 1 '()) 1) (cons 1 '()))
(define (set+.R s x)
  (if (member? x s)
      s
      (cons x s)))
