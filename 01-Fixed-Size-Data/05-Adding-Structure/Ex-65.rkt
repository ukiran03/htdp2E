#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex-65) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------- For
;; ---------- DrRacket

(define-struct movie [title director year])
(make-movie "Cure" "Kiyoshi Kurosawa" "1997")
(make-movie "August in the water" "Sogo Ishii" "1995")

(define (release-year mov)
  (movie-year mov))
(release-year (make-movie "Kairo" "Kiyoshi Kurosawa" "2000"))

