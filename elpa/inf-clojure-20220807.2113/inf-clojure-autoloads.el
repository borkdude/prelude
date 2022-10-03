;;; inf-clojure-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "inf-clojure" "inf-clojure.el" (0 0 0 0))
;;; Generated autoloads from inf-clojure.el

(defvar inf-clojure-mode-line '(:eval (format " inf-clojure[%s]" (inf-clojure--modeline-info))) "\
Mode line lighter for cider mode.

The value of this variable is a mode line template as in
`mode-line-format'.  See Info Node `(elisp)Mode Line Format' for details
about mode line templates.

Customize this variable to change how inf-clojure-minor-mode
displays its status in the mode line.  The default value displays
the current REPL.  Set this variable to nil to disable the
mode line entirely.")

(custom-autoload 'inf-clojure-mode-line "inf-clojure" t)

(autoload 'inf-clojure-minor-mode "inf-clojure" "\
Minor mode for interacting with the inferior Clojure process buffer.

This is a minor mode.  If called interactively, toggle the
`Inf-Clojure minor mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `inf-clojure-minor-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

The following commands are available:

\\{inf-clojure-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'inf-clojure "inf-clojure" "\
Run an inferior Clojure process, input and output via buffer `*inf-clojure*'.
If there is a process already running in `*inf-clojure*', just
switch to that buffer.

CMD is a string which serves as the startup command or a cons of
host and port.

 Prompts user for repl startup command and repl type if not
inferrable from startup command.  Uses `inf-clojure-custom-repl-type'
and `inf-clojure-custom-startup' if those are set.
Use a prefix to prevent using these when they
are set.

 Runs the hooks from `inf-clojure-mode-hook' (after the
`comint-mode-hook' is run).  (Type \\[describe-mode] in the
process buffer for a list of commands.)

\(fn CMD)" t nil)

(autoload 'inf-clojure-connect "inf-clojure" "\
Connect to a running socket REPL server via `inf-clojure'.
HOST is the host the process is running on, PORT is where it's listening.

\(fn HOST PORT)" t nil)

(register-definition-prefixes "inf-clojure" '("inf-clojure-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; inf-clojure-autoloads.el ends here
