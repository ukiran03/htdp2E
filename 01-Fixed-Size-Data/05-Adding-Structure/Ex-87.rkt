#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

;; Exercise 87.
;; Develop a data representation for an editor based on our first idea,
;; using a string and an index.

(require 2htdp/image)
(require 2htdp/universe)

;; Constants and Data Definitions

;; An Index is a Number
;; greater than 0 or equal to 0.
;; represents a posn in a String.

(define-struct editor [content point])
;; An Editor is a structure:
;; (make-editor String Index)
;; (make-editor s i) describes an editor with
;; - the visible text s,
;; - the point to cursor at Index i.

(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 20)
(define CURSOR-COLOR "red")

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 20)

(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" CURSOR-COLOR))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))


;; Functions

;; Editor -> Editor
;; Launches an interactive editor.
;; Usage: (run (make-editor "hi-fi" 3))
(define (run ed)
  (big-bang ed
    [to-draw render]
    [check-with editor?] ; exercise 114
    [on-key edit]))


;; Editor -> Image
;; Renders an editor image.

(define (render ed)
  (overlay/align
   "left" "center"
   (beside
    (draw-text (substring (editor-content ed) 0 (editor-cursor-at ed)))
    CURSOR
    (draw-text (substring (editor-content ed) (editor-cursor-at ed))))
   SCENE))

