#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct posn [x y])
;; A Posn is a structure:
;; (make-posn Number Number)
;; interpretation a point x pixels from left, y from top

(define-struct entry [name phone email])
;; A Entry is a structure:
;; (make-entry String String String)
;; interpretation a contact's name, phone#, and email

(define-struct ball [location velocity])
;; A Ball-1d is a structure:
;; (make-ball Number Number)
;; interpretation 1 distance to top and velocity
;; interpretation 2 distance to left and velocity

;; A Ball-2d is structure:
;; (make-ball Posn Vel)
;; interpretation a 2-dimensional position and velocity

(define-struct vel [deltax deltay])
;; A Vel is a structure:
;; (make-vel Number Number)
;; interpretation (make-vel dx dy) means a velocity of
;; dx pixels [per tick] along the horizontal and
;; dy pixels [per tick] along the vertical direction

