#reader(lib "htdp-beginner-reader.ss" "lang")((modname file2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/batch-io)

(define (sign x)
  (cond
    [ (> x 0) 1]
    [ (= x 0) 0]
    [ (< x 0) -1]))

(define x 3)
(define y 4)


(define str "helloworld")
(define ind "0123456789")
(define i 5)

;; (string-append (string-ith str 0) (string-ith str 1) (string-ith str 2))

;; (define (my-str str i start)
;;     (unless (= start i)
;;       (string-append (string-ith str start) (my-str str i (+ start 1)))))

(define (add-underscore str pos)
  (string-append (substring str 0 pos) "_" (substring str pos (string-length str))))

;; Application
;; (string-append (substring str 0 i) "_" (substring str i))

;; ex-7
(define sunny #true)
(define friday #false)
;; either not-sunny or friday
(define is-it-app (or (not sunny) friday))

(define (inverse-of-x x)
  (if (= x 0) 0 (/ 1 x)))

;; (define in 42)
;; (string-length in)
(define (string-length-or-number in)
  (if (string? in)
      (string-length in)
      (string-length (number->string in))))

;; ex-9
(define in 42)
(define (change-in in)
  (if (string? in) (string-length in)
      (if (boolean? in)
          (cond
            [ (boolean=? #t in) 10]
            [ (boolean=? #f in) 20])
          (if (number? in)
              (cond
                [ (= in 0) in]
                [ (negative? in) (- in)]
                [ (> in 0) (- in 1)])
              (error "Neither a number nor a string nor a boolean")))))

;; ex-11
(define (dist x y)
  (sqrt (+ (* x x) (* y y))))

;; ex-12
(define (cvolume a)
  (* a a a))

;; ex-13
(define (string-first str)
  (string-ith str 0))

;; ex-14
(define (string-last str)
  (string-ith str (- (string-length str) 1)))

;;ex-15
(define (===> sunny friday)
  (or (boolean=? #f sunny) (boolean=? #t friday)))
;; (or (not sunny) friday)

;; ex-19
(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))

;; ex-20
(define (string-delete str i)
  (if (<= (string-length str) 1)
      (error "Empty string")
      (if (> i (string-length str))
          (error "i exceeded string length")
      (string-append
       (substring str 0 i)
       (substring str (+ i 1))))))

;; ex-22
(define (dist-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))



