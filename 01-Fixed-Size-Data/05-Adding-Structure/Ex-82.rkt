#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; A Letter is one of:
;; - 1String "a" through "z",
;; - #false.
;; Represents a lowercase letter of a Latin alphabet.
;; #false denotes exceptional cases

(define-struct word [l1 l2 l3])

;; A Word is a Struture:
;; (make-word Letter Letter Letter).
;; (make-word l1 l2 l3) represents
;; an English language three-letter word
;; that consists of:
;; - the first Letter l1,
;; - the second Letter l2, and
;; - the third [final] Letter l3.

;; Word Word -> Word
;; Compare two given words.
;; Based on the comparision results,
;; produces a word consisting of
;; - matching Letters,
;; - #false in place of mismatching Letters.
;; [The function was intentional named compare-words
;; instead of comapare-word.]
(check-expect (compare-words
               (make-word "c" "a" "t")
               (make-word "c" "a" "t"))
              (make-word "c" "a" "t"))
(check-expect (compare-words
               (make-word "c" #false "t")
               (make-word "c" "a" "p"))
              (make-word "c" #false #false))
(check-expect (compare-words
               (make-word #false #false "t")
               (make-word #false "a" "p"))
              (make-word #false #false #false))
(define (compare-words w1 w2)
  (make-word
   [compare-letters (word-l1 w1) (word-l1 w2)]
   [compare-letters (word-l2 w1) (word-l2 w2)]
   [compare-letters (word-l3 w1) (word-l3 w2)]))

;; Letter Letter -> Letter
;; Compare two Letters.
;; Produces
;; - #false if the Letters are not equal,
;; - a Letter value otherwise
(check-expect (compare-letters "a" "a") "a")
(check-expect (compare-letters "a" "b") #false)
(check-expect (compare-letters "a" #false) #false)
(check-expect (compare-letters #false #false) #false)
(define (compare-letters l1 l2)
  (cond
    [(and (string? l1) (string? l2))
     (cond
       [(string=? l1 l2) l1]
       [else #false])]
    [else #false]))
