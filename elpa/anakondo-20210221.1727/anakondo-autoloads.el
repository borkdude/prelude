;;; anakondo-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "anakondo" "anakondo.el" (0 0 0 0))
;;; Generated autoloads from anakondo.el

(autoload 'anakondo-minor-mode "anakondo" "\
Minor mode for Clojure[Script] completion powered by clj-kondo.

Toggle anakondo-minor-mode on or off.

With a prefix argument ARG, enable anakondo-minor-mode if ARG is
positive, and disable it otherwise. If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is ‘toggle’.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "anakondo" '("anakondo-"))

;;;***

;;;### (autoloads nil nil ("anakondo-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; anakondo-autoloads.el ends here
