#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-84) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

(define MTSN (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "blue"))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
; the cursor displayed between s and t


;; Helper Functions !!

;; String -> 1String ;; ex-13
(define (string-first str)
  (if (< (string-length str) 1)
      str
      (string-ith str 0)))

;; String -> 1String ;; ex-14
(define (string-last str)
  (if (< (string-length str) 1)
      str
      (string-ith str (- (string-length str) 1))))

;; String -> String
(define (str-del-last str)
  (if (< (string-length str) 1)
      ;; (error "Empty String")
      str
      (substring str 0 (- (string-length str) 1))))

;; String -> String
(define (str-del-first str)
  (if (< (string-length str) 1)
      ;; (error "Empty String")
      str
      (substring str 1 (string-length str))))

;; Editor -> Editor
(check-expect (mv-left (make-editor "Claude " "Shannon")) (make-editor "Claude" " Shannon"))
(check-expect (mv-left (make-editor "Hello" "World")) (make-editor "Hell" "oWorld"))
(check-expect (mv-left (make-editor "H" "ello World")) (make-editor "" "Hello World"))
(define (mv-left ed)
  (make-editor (str-del-last (editor-pre ed))
               (string-append (string-last (editor-pre ed))
                              (editor-post ed))))
;; Editor -> Editor
(check-expect (mv-right (make-editor "Claude " "Shannon")) (make-editor "Claude S" "hannon"))
(check-expect (mv-right (make-editor "Hello" "World")) (make-editor "HelloW" "orld"))
(check-expect (mv-right (make-editor "Hello Worl" "d")) (make-editor "Hello World" ""))
(define (mv-right ed)
  (make-editor (string-append (editor-pre ed)
                              (string-first (editor-post ed)))
               (str-del-first (editor-post ed))))



;;Editor -> Editor
(check-expect (edit2 (make-editor "Claude " "Shannon") "E")
              (make-editor "Claude E" "Shannon"))
(check-expect (edit2 (make-editor "Claude " "Shannon") "\b")
              (make-editor "Claude " "Shannon"))
(check-expect (edit2 (make-editor "Claude " "Shannon") "left")
              (make-editor "Claude" " Shannon"))
(check-expect (edit2 (make-editor "Claude " "Shannon") "right")
              (make-editor "Claude S" "hannon"))
(define (edit2 ed ke)
  (cond
    [(string=? "left" ke) (mv-left ed)]
    [(string=? "right" ke) (mv-right ed)]
    [else
     (make-editor (string-append (editor-pre ed)
                                      (cond
                                        [(or (string=? "\b" ke)
                                             (string=? "\t" ke)
                                             (string=? "\r" ke)) ""]
                                        [else ke])) (editor-post ed))]))

;; (define sometext "hello world")
;; String String -> Scene Editing
(define (render editor)
  (overlay/align "left" "center"
                 (beside (text (editor-pre editor) 16 "black")
                         CURSOR
                         (text (editor-post editor) 16 "black"))
                 MTSN))
;; (render (make-editor "Claude " "Shannon"))
