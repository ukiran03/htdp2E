#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Data Representation

;; A Attribute is one of
;; - Number greater that or equal to 0
;; - #false

(define-struct animal [legs volume len girth])
;; An Animal is a structure:
;; (make-animal Attribute Attribute Attribute Attribute)
;; (make-animal l v len g) represents an animal with
;; - l number of legs
;; - v volume of a required cage
;; - len length of an animal
;; - g girth of an animal
