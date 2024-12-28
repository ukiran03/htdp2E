#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-112) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (missile-or-not? v)
  (cond
    [(or (false? v) (posn? v)) #true]
    [else #false]))
