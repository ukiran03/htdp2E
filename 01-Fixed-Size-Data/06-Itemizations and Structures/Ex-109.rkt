#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;; Exercise 109.
;; Design a world program that recognizes a pattern in a sequence of KeyEvents.

;;; Constants and Data Definitions

;; A KeyEvent is one of:
;; - "a"
;; - "b"
;; - "c"
;; - "d"
;; Represents key presses.

(define AA "white")
(define BC "yellow")
(define DD "green")
(define ER "red")

;; An FSMState is one of:
;; – AA
;; – BC
;; – DD
;; – ER
;; Represents states of the finite state machine with
;; each state reached in a particular order on these events:
;; - AA on the initial "a" key press,
;; followed by
;; - BC on any number of "b" and "c" key presses,
;; - DD on "d" key press;
;; - and ER on not accepted key press.
;; The finite state machine with these states can be represented
;; by this regular expression:  a (b|c)* d

(define WIDTH 100)
(define HEIGHT 100)

;; FSMState -> Image
;; Renders an image corresponding to the current world state.
(check-expect (render AA) (rectangle WIDTH HEIGHT "solid" "white"))
(check-expect (render BC) (rectangle WIDTH HEIGHT "solid" "yellow"))
(check-expect (render DD) (rectangle WIDTH HEIGHT "solid" "green"))
(check-expect (render ER) (rectangle WIDTH HEIGHT "solid" "red"))
(define (render state)
  (rectangle WIDTH HEIGHT "solid" state))

;; FSMState KeyEvent -> FSMState
;; Changes state of the finite state machine on a key press.
(check-expect (input-state AA "a") BC)
(check-expect (input-state AA "b") ER)
(check-expect (input-state BC "b") BC)
(check-expect (input-state BC "c") BC)
(check-expect (input-state BC "d") DD)
(check-expect (input-state BC "a") ER)
(define (input-state s key)
  (cond
    [(or (string=? s AA) (string=? s ER))
     (if (key=? key "a") BC ER)]
    [(or (string=? s BC) (string=? s ER))
     (cond
       [(or (key=? key "b") (key=? key "c")) BC]
       [(key=? key "d") DD]
       [else ER])]
    [else s]))

;; FSMState -> FSMState
(define (fsm s)
  (big-bang s
            [to-draw render]
            [on-key input-state]))
;; Usage: (fsm AA)
