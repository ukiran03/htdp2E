#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct time [hours minutes seconds])

(define MIDNIGHT (make-time 12 00 00))

;; Time -> Time
;; interpretation: gives the difference b/w given two time stamps
(define (time-diff t1 t2)
  (make-time (abs (- (time-hours t1) (time-hours t2)))
             (abs (- (time-minutes t1) (time-minutes t2)))
             (abs (- (time-seconds t1) (time-seconds t2)))))

;; Time -> Number
;; gives the number of seconds since last midnight 12:00:00
;; :MODIFIED:
(define (time->seconds time)
  (+ (* 60 60 (time-hours (time-diff MIDNIGHT time)))
     (* 60 (time-minutes (time-diff MIDNIGHT time)))
     (time-seconds (time-diff MIDNIGHT time))))
