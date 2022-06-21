;;; hlint-refactor-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "hlint-refactor" "hlint-refactor.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from hlint-refactor.el

(autoload 'hlint-refactor-refactor-buffer "hlint-refactor" "\
Apply all hlint suggestions in the current buffer.
ARGS specifies additional arguments that are passed to hlint.

\(fn &optional ARGS)" t nil)

(autoload 'hlint-refactor-refactor-at-point "hlint-refactor" "\
Apply the hlint suggestion at point." t nil)

(autoload 'hlint-refactor-mode "hlint-refactor" "\
Automatically apply hlint suggestions

This is a minor mode.  If called interactively, toggle the
`hlint-refactor mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `hlint-refactor-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "hlint-refactor" '("hlint-refactor-call-process-region-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; hlint-refactor-autoloads.el ends here
