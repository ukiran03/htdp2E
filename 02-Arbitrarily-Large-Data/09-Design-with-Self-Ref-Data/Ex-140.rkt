#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; A List-of-Bools is one of:
; - '()
; - (cons Boolean List-of-Bools)

(check-expect (all-true t1) #true)
(check-expect (all-true t2) #false)
(check-expect (all-true t3) #false)
(check-expect (all-true t4) #false)
(define (all-true lob)
  (cond
    [(empty? lob) #true]
    [(cons? lob) (and (not (false? (first lob))) (all-true (rest lob)))]
    [else #false]))

(check-expect (one-true t1) #true)
(check-expect (one-true t2) #true)
(check-expect (one-true t3) #true)
(check-expect (one-true t4) #false)
(define (one-true lob)
  (cond
    [(empty? lob) #false]
    [(cons? lob) (or (not (false? (first lob))) (one-true (rest lob)))]
    [else #false]))

(define t1
  (cons #true (cons #true (cons #true '()))))

(define t2
  (cons #true (cons #false (cons #true '()))))

(define t3
  (cons #false (cons #false (cons #true '()))))

(define t4
  (cons #false (cons #false (cons #false '()))))
