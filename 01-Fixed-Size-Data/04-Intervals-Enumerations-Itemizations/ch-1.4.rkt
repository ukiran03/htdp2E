#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch-1.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;;
;; Exercise 47.
;; Design a world program that maintains and displays a "happiness gauge."

;; 4. Intervals, Enumerations, and Itermizations

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [(< 20 s) "gold"])) ;catch a -ve number

(define (reward2 s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"])) ;dont catch a -ve number

;; ex-49
(define (calc-y y)
  (- 200
     (cond
       [(> y 200) 0]
       [else y])))

;; TrafficLight -> TrafficLight
;; gives the next state state of s
;; (check-expect (traffic-light-next "red") "green")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

