#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-63) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket


(check-expect (dist-to-0 (make-posn 3 4)) 5)
(check-expect (dist-to-0 (make-posn 8 6)) 10)
(check-expect (dist-to-0 (make-posn 5 12)) 13)
(define (dist-to-0 ap)
  (sqrt
   (+ (sqr (posn-x ap))
      (sqr (posn-y ap)))))
