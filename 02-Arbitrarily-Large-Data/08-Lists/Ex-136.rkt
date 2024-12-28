#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-136) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct pair [left right])
;; A ConsPair is a structure
;; (make-pair Any Any)

;; A ConsOrEmpty is one of:
;; - '()
;; - (make-pair Any ConsOrEmpty)
;; is a list of 0 items or more

;; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

;; ConsOrEmpty -> Any
;; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

;; ConsOrEmpty -> Any
;; extracts the rest part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest ",,,")
      (pair-right a-list)))

;; -- Exercise 136 --

(our-first (our-cons "a" '()))
(our-rest (our-cons "a" '()))
