#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-123) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 123. The use of if may have surprised you in another way
;; because this intermezzo does not mention this form elsewhere. In
;; short, the intermezzo appears to explain and with a form that has
;; no explanation either. At this point, we are relying on your
;; intuitive understanding of if as a short-hand for cond. Write down
;; a rule that shows how to reformulate

;; (if expr-test expr-then expr-else) as a cond expression.

;; (define answer
;;   (cond
;;     [expr-test expr-then]
;;     [else expr-else]))
