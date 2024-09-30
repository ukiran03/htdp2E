#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-85) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(require 2htdp/image)
(require 2htdp/universe)

(define MTSN (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "blue"))

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
; the cursor displayed between s and t

(define (draw-text str)
  (text str TEXT-SIZE TEXT-COLOR))

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
(define (mv-left ed)
  (make-editor (str-del-last (editor-pre ed))
               (string-append (string-last (editor-pre ed))
                              (editor-post ed))))
;; Editor -> Editor
(define (mv-right ed)
  (make-editor (string-append (editor-pre ed)
                              (string-first (editor-post ed)))
               (str-del-first (editor-post ed))))
;; Editor -> Editor
(define (backspace ed)
  (make-editor (str-del-last (editor-pre ed)) (editor-post ed)))

;; Editor -> Editor
;; (define (edit ed ke)
;;   (cond
;;     [(string=? "left" ke) (mv-left ed)]
;;     [(string=? "right" ke) (mv-right ed)]
;;     [(string=? "\b" ke) (backspace ed)]
;;     [else (make-editor (string-append
;;                         (editor-pre ed)
;;                         (cond [(or (string=? "\t" ke)
;;                                    (string=? "\r" ke)) ""]
;;                               [else ke]))
;;                        (editor-post ed))]))
(define (edit-v2 ed ke)
  (cond
    [(string=? "left" ke) (mv-left ed)]
    [(string=? "right" ke) (mv-right ed)]
    [(string=? "\b" ke) (backspace ed)]
    [(insert? ed ke) (make-editor
                      (string-append (editor-pre ed) ke)
                      (editor-post ed))]
    [else ed]))

;; For Tests Only
(define ed-0 (make-editor "" "hi-fi"))
(define ed-3 (make-editor "hi-" "fi"))
(define ed-5 (make-editor "hi-fi" ""))
(define ed-200 (make-editor "" (make-string 200 #\a)))
(define ed-empty (make-editor "" ""))

;; Editor KeyEvent -> Boolean
;; Identifies if to insert a typed key into an editor.
(check-expect (insert? ed-0 "a") #true)
(check-expect (insert? ed-0 "up") #false)
(check-expect (insert? ed-0 "\t") #false)
(check-expect (insert? ed-0 "\r") #false)
(check-expect (insert? ed-200 "a") #false)

(define (insert? ed ke)
  (and (= (string-length ke) 1)
       (not (string=? ke "\t"))
       (not (string=? ke "\r"))
       (<
        (image-width (draw-text (string-append (editor-pre ed) (editor-post ed))))
        (- (image-width MTSN) 10))))

;; Editor -> Scene Editing
(define (render editor)
  (overlay/align "left" "center"
                 (beside (text (editor-pre editor) 16 "black")
                         CURSOR
                         (text (editor-post editor) 16 "black"))
                 MTSN))

(define (run ed)
  (big-bang ed
            [to-draw render]
            [on-key edit-v2]))
;; (render (make-editor "Claude " "Shannon"))
