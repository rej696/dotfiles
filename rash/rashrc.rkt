#lang rash

(provide
  ls
  ll
  la)

(require readline/pread)
(require racket/string)
(require racket/list)
(require rash/private/rashrc-lib)
(require shell/pipeline-macro)

(define (mstyle n)
  (lambda (s) (format "\033[~am~a" n s)))
(define (mbstyle n)
  (lambda (s) (format "\033[01;~am~a" n s)))
(define red (mbstyle 31))
(define green (mbstyle 32))
(define default-style (mstyle 0))

(define (my-prompt)
  (printf "~a~a~a ~a~a"
          (red "[")
          (green (last (string-split (path->string (current-directory)) "/")))
          #;(green (path->string (current-directory)))
          (red "]")
          (green "\u03BB") ; unicode lambda
          #;(green "$")
          (default-style " "))
  (readline-prompt #"> "))

(current-prompt-function my-prompt)

(define-simple-pipeline-alias ls 'ls '--color=auto)
(define-simple-pipeline-alias ll 'ls '--color=auto '-l)
(define-simple-pipeline-alias la 'ls '--color=auto '-l '-a)
