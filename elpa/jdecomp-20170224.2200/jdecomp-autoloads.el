;;; jdecomp-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "jdecomp" "jdecomp.el" (0 0 0 0))
;;; Generated autoloads from jdecomp.el

(autoload 'jdecomp-preview-mode "jdecomp" "\
Major mode for previewing decompiled Java class files.

\\{jdecomp-preview-mode-map}

\(fn)" t nil)

(autoload 'jdecomp-decompile "jdecomp" "\
Decompile FILE and return buffer of decompiled contents.

FILE must be a Java class file.

Optional parameter JAR is the name of the JAR archive FILE is
in.

\(fn FILE &optional JAR)" nil nil)

(autoload 'jdecomp-decompile-and-view "jdecomp" "\
Decompile FILE and view buffer of decompiled contents.

FILE must be a Java class file.  If called interactively, FILE is
the name of the file the current buffer is visiting.

Optional parameter JAR is the JAR file containing FILE, if
applicable.

\(fn FILE &optional JAR)" t nil)

(defvar jdecomp-mode nil "\
Non-nil if Jdecomp mode is enabled.
See the `jdecomp-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `jdecomp-mode'.")

(custom-autoload 'jdecomp-mode "jdecomp" nil)

(autoload 'jdecomp-mode "jdecomp" "\
Automatically decompile Java class files.

If called interactively, enable Jdecomp mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jdecomp" '("jdecomp-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; jdecomp-autoloads.el ends here
