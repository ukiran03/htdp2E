#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

;; Exercise 83. Design the function render, which consumes an Editor
;; and produces an image.

(define MTSN (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "blue"))

(define sometext "hello world")

;; String String -> Scene Editing
(define (render editor)
  (overlay/align "left" "center"
                 (beside (text (editor-pre editor) 16 "black")
                         CURSOR
                         (text (editor-post editor) 16 "black"))
                 MTSN))

(render (make-editor (substring sometext 0 6) (substring sometext 6)))
(render (make-editor "Claude " "Shannon"))

