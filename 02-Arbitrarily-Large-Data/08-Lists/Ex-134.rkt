#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(check-expect
 (contains? "Glatt" (cons "X" (cons "Y"  (cons "Z" '()))))
 #false)
(check-expect
 (contains? "Flatt" (cons "A" (cons "Flatt" (cons "C" '()))))
 #true)
(define (contains? name alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) name)
         (contains? name (rest alon)))]))
