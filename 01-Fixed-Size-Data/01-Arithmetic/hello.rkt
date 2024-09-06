#lang racket

;; Define a function that returns a greeting message
(define (greet name)
  (string-append "Hello, " name "!"))

;; Call the greet function
(define my-greeting (greet "World"))

;; Print the greeting to the console
(displayln my-greeting)

;; Define a function to determine if a number is positive, negative, or zero
(define (check-number n)
  (cond
    [(> n 0) "The number is positive."]
    [(< n 0) "The number is negative."]
    [else "The number is zero."]))

;; Test the check-number function
(displayln (check-number 10))
(displayln (check-number -5))
(displayln (check-number 0))


