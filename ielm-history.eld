markdown-command
(def foo.bar 1)
(defq foo.bar 1)
(def x 1)
(defvar x 1)
(defvar x.1 1)
(require 'cljbang)
(defun fib (n)
  (if (< n 2)
      n
    (+ (fib (- n 1))
       (fib (- n 2)))))
(benchmark-run 1
    (fib 35)))
(benchmark-run 1 (fib 35))
(clj! (+ 1 2 3))
(clj! #{})
false
(clj! (+ 1 2 3))
(clj! (+ 1 2 (el! (+ 1 2 3))))
