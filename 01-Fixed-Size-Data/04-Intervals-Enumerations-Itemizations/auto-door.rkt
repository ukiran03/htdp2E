#reader(lib "htdp-beginner-reader.ss" "lang")((modname auto-door) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(require 2htdp/image)
(require 2htdp/universe)

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

;; A DoorState is one of: LOCKED CLOSED OPEN

;; State -> State
;; closes an open door over the period of one tick
(check-expect (door-closer "locked") "locked")
(check-expect (door-closer "closed") "closed")
(check-expect (door-closer "open") "closed")

(define (door-closer state)
  (cond
    [(string=? LOCKED state) LOCKED]
    [(string=? CLOSED state) CLOSED]
    [(string=? OPEN state) CLOSED]))


;; Key -> State
;; acts on it in response to pressing a key;
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

(define (door-action state key)
  (cond
    [(and (string=? LOCKED state) (string=? "u" key)) CLOSED]
    [(and (string=? CLOSED state) (string=? "l" key)) LOCKED]
    [(and (string=? CLOSED state) (string=? " " key)) OPEN]
    [else state]))

;; State -> Image
;; translates the current state into an image
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(define (door-render state)
  (text state 40 "red"))

;; State -> State
;; simulates a door with an automatic door closer
(define (door-simulation inital-state)
  (big-bang inital-state
            [on-tick door-closer 3]     ; door closes after 3 seconds
            [on-key door-action]
            [to-draw door-render]))
