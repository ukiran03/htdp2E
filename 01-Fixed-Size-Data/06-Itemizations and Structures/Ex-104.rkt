#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-104) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 104.
;; Develop a data representation for these vehicles:
;; - automobiles
;; - vans
;; - buses
;; - SUVs
;; The representation of each vehicle must describe:
;; - the number of passengers that it can carry
;; - its license plate number
;; - its fuel consumption (miles per gallon)
;; Develop a template for functions that consume vehicles.


;;; Data Definitions

;; A VehicleType is one of:
;; - "automoblie"
;; - "van"
;; - "bus"
;; - "SUV"

;; A PositiveNumber is a Number
;; greater than or equal to 0.

(define-struct vehicle [type passengers plate fuel])
;; A Vehicle is a structure:
;;   (make-vehicle VehicleType PositiveNumber String PositiveNumber)
;; (make-vehicle t p pl f) represents a vehicle with these parameters:
;; - a vehicle type t
;; - a number of passengers it can carry p
;; - a license plate number pl
;; - a fuel consumption f in miles per gallon
