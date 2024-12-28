#reader(lib "htdp-beginner-reader.ss" "lang")((modname 8.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; List-of-names

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (... (string=? (first alon) "Flatt")
          ... (rest alon) ...)]))

(define-struct pair [left right])
;; A ConsPair is a structure
;; (make-pair Any Any)

;; A ConsOrEmpty is one of:
;; - '()
;; - (make-pair Any ConsOrEmpty)

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

(define my-list
  (our-cons "A" (our-cons "Flatt" (our-cons "C" '()))))

(our-first my-list)
(our-rest my-list)
(pair? my-list)