#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-115) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given some other value")

;; Any Any -> Boolean
;; are the two values elements of TrafficLight and,
;; if so, are they equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "yellow" "red") #false)

(define (light=? A B)
  (if (and (light? A) (light? B))
      (string=? A B)
      (error MESSAGE)))

;; Revised light=?
(check-expect (re-light=? "red" "red") #true)
(check-expect (re-light=? "yellow" "red") #false)
;; (check-expect (re-light=? "OOO" "red") (error "A is not a TrafficLight"))
;; (check-expect (re-light=? "green" "ZZZ") (error "B is not a TrafficLight"))

(define (re-light=? A B)
  (cond
    [(not (light? A)) (error "A is not a TrafficLight")]
    [(not (light? B)) (error "B is not a TrafficLight")]
    [else (string=? A B)]))

;; (re-light=? "OOO" "red")
