#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct phone# [area switch num])
;; A Phone# is a structure:
;; (make-phone# Number Number Number)
;; interpretation:
;; area is an area code [000, 999],
;; switch is a switch code [000, 999],
;; num is a local number [0000, 9999],
