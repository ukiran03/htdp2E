#reader(lib "htdp-beginner-reader.ss" "lang")((modname bouncing-balls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct ball [location velocity])

(define-struct balld [location direction])

(define-struct vel [deltax deltay])

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

;; contact lists

(define-struct centry [name home office cell])

(define-struct phone [area number])

(make-centry "Ushakiran"
             (make-phone 207 "363-2421")
             (make-phone 101 "776-1099")
             (make-phone 208 "112-9981"))
