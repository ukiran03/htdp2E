#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-70) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct centry [name home office cell])
(define-struct phone [area number])

(phone-area
 (centry-office
  (make-centry "Ushakiran"
               (make-phone 207 "363-2421")
               (make-phone 101 "776-1099")
               (make-phone 208 "112-9981")))) ; 101

(phone-number
 (centry-office
  (make-centry "Ushakiran"
               (make-phone 207 "363-2421")
               (make-phone 101 "776-1099")
               (make-phone 208 "112-9981")))) ; 112-9981

(define ap (make-posn 7 0))
(define pl (make-centry "Al Abe" "666-7771" "789-2501" "lee@x.me"))

