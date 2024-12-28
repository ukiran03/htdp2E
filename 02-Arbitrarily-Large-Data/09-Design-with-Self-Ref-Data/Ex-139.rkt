#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of-Amount)

(define (sum l)
  (cond
    [(empty? l) 0]
    [(cons? l)
     (+ (first l) (sum (rest l)))]))


; A List-of-numbers is one of:
; – '()
; – (cons Number List-of-numbers)

;; List-of-Numbers -> Boolean
; determines that all elements of the given list are Positive
(define (pos? l)
  (cond
    [(empty? l) #true]
    [(cons? l)
     (and (positive? (first l))
          (pos? (rest l)))]))

(define test1
  (cons 12 (cons -23 (cons 34 (cons 45 '())))))
(define test2
  (cons 12 (cons 23 (cons 34 (cons 45 '())))))

(pos? test1)
(pos? test2)

;; List-of-Number -> Sum or Error
(define (checked-sum l)
  (cond
    [(empty? l) 0]
    [(pos? l) (sum l)]
    [else (error "Not a List-of-Amounts")]))

(checked-sum test2)
(checked-sum test1)
