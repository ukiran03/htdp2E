#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-163) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; For
;; DrRacket

;; Exercise 163. Design convertFC. The function converts a list of
;; measurements in Fahrenheit to a list of Celsius measurements

; List-of-numbers -> List-of-numbers
; converts measurments from F to C
(define (convertFC flist)
  (cond
    [(empty? flist) '()]
    [else
     (cons (* 5/9 (- (first flist) 32))
           (convertFC (rest flist)))]))

(check-within (convertFC (cons 0 (cons 32 (cons 212 '()))))
              (cons -17.78 (cons 0 (cons 100 '()))) 0.01)
