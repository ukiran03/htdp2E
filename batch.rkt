#lang racket

;; #lang 2htdp/beginner
;; (require lang/htdp-advanced)
;; (require htdp/image)
(require 2htdp/batch-io)

(define (letter fst lst signature-name)
  (string-append (opening fst) "\n\n" (body fst lst) "\n\n" (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append "We have discovered that all people with the"
                 "\n"
                 "last name "
                 lst
                 " have won our lottery. So, "
                 "\n"
                 fst
                 ", "
                 "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append "Sincerely," "\n\n" signature-name "\n"))
