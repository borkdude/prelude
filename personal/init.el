;;; package --- My own config

;;; Commentary:
;;; My config
(set-frame-font "Menlo" nil t)

;; fix for issue https://github.com/railwaycat/homebrew-emacsmacport/issues/384#issuecomment-2643696683
(defun my/tool-bar-on-and-off ()
  (tool-bar-mode 1)
  (tool-bar-mode 0))

(add-hook 'window-setup-hook #'my/tool-bar-on-and-off)
(add-hook 'after-make-frame-functions (lambda (frame) (my/tool-bar-on-and-off)))

;;; Code:
(prelude-require-packages '(markdown-mode
                            multi-term
                            slim-mode
                            sass-mode
                            rvm
                            inf-clojure
                            ag
                            projectile-rails
                            ;; clj-refactor
                            ;; flycheck-clojure
                            flycheck-pos-tip
                            jedi
                            use-package
                            neotree
                            auto-highlight-symbol
                            haskell-mode
                            ;; intero
                            flymake-hlint
                            ;; hlint-refactor uses https://github.com/mpickering/apply-refact
                            ;; install by running the following outside a project dir: stack --resolver=nightly install apply-refact
                            hlint-refactor

                            ;; install joker first
                            ;; https://github.com/candid82/joker#installation
                            ;; flycheck-joker
                            adoc-mode
                            ido-vertical-mode
                            purescript-mode
                            reveal-in-osx-finder
                            exec-path-from-shell ;; fix path in Emacs by reading from .zshenv
                            ;; flycheck-clj-kondo
                            flycheck-rust
                            rust-mode
                            lsp-mode ;; lsp-ui lsp-treemacs
                            adoc-mode
                            anakondo
                            git-gutter
                            flycheck-inline
                            org-present
                            vterm ;; needs brew install cmake
                            markdown-toc
                            ;; flycheck-yamllint
                            nvm
                            posframe))

(nvm-use "20")

;; (require 'flycheck-joker)
;; (require 'flycheck-clj-kondo)
(require 'flycheck-rust)
;; (require 'anakondo)

;; ;; Enable anakondo-minor-mode in all Clojure buffers
;; (add-hook 'clojure-mode-hook #'anakondo-minor-mode)
;; ;; Enable anakondo-minor-mode in all ClojureScript buffers
;; (add-hook 'clojurescript-mode-hook #'anakondo-minor-mode)
;; ;; Enable anakondo-minor-mode in all cljc buffers
;; (add-hook 'clojurec-mode-hook #'anakondo-minor-mode)

;; (defun fci-hook ()
;;   (setq-default fci-rule-column 80)
;;   (fci-mode 1))

;; (add-hook 'prog-mode-hook 'fci-hook)

;; window size on startup
;; (if (window-system) (set-frame-size (selected-frame) 200 56))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; obsolete, use crux-rename-file-and-buffer
;; (defun rename-file-and-buffer (new-name)
;;   "Renames both current buffer and file it's visiting to NEW-NAME."
;;   (interactive "sNew name: ")
;;   (let ((name (buffer-name))
;;         (filename (buffer-file-name)))
;;     (if (not filename)
;;         (message "Buffer '%s' is not visiting a file!" name)
;;       (if (get-buffer new-name)
;;           (message "A buffer named '%s' already exists!" new-name)
;;         (progn
;;           (rename-file name new-name 1)
;;           (rename-buffer new-name)
;;           (set-visited-file-name new-name)
;;           (set-buffer-modified-p nil))))))

(require 'lsp)

(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (if (and (lsp-workspaces)
           (lsp--capability "documentFormattingProvider")
           )
      ;; (lsp-format-buffer)
    (indent-region (point-min) (point-max) nil))
  (untabify (point-min) (point-max)))

(global-set-key (kbd "<f7>") 'iwb)

(global-set-key (kbd "<f9>") 'profiler-start)
(global-set-key (kbd "<f10>") 'profiler-stop)

;; (add-hook 'mouse-leave-buffer-hook
;;           (lambda ()
;;             (let ((mode (message "%s" major-mode)))
;;               (if (string= "clojure-mode" mode)
;;                   (iwb)
;;                 (progn (print "mode is not clojure mode") (print mode))
;;                 ))))

;; TODO: try this:
;; (defvar auto-indent-modes
;;   '(clojure-mode emacs-lisp-mode))

;; (defun indent-maybe ()
;;   (when (member major-mode auto-indent-modes)
;;     (indent-region (point-min) (point-max))))

;; (add-hook 'before-save-hook #'indent-maybe)



;; see http://rawsyntax.com/blog/learn-emacs-zsh-and-multi-term/
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "s-v") 'term-paste)))

(visual-line-mode) ;; probably I have hook this up to some modes

(provide 'michiel-config)
;;; init.el ends here

;; disable automatic scss compilation on save
(custom-set-variables '(scss-compile-at-save nil))

;; Don't show whitespace
(setq prelude-whitespace nil)
;; Do not warn about arrow keys
(setq prelude-guru nil)

;; coffeescript-mode
(custom-set-variables '(coffee-tab-width 2))

;; slim template mode
(custom-set-variables '(slim-backspace-backdents-nesting nil))

;; js2mode
(setq-default js2-basic-offset 2)

;; magit
(setq magit-last-seen-setup-instructions "1.4.0")

;; projectile
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; emacs server

(require 'server)
(unless (server-running-p)
  (server-start))

;; clj-refactor
;; (require 'clj-refactor)

;; neotree
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

;; highlighting
(setq global-auto-highlight-symbol-mode t)

;; flyspell

(setq prelude-flyspell nil)
;; source: https://www.emacswiki.org/emacs/FlySpell
;; (defun fd-switch-dictionary()
;;   (interactive)
;;   (let* ((dic ispell-current-dictionary)
;;          (change (if (string= dic "nl") "en" "nl")))
;;     (ispell-change-dictionary change)
;;     (message "Dictionary switched from %s to %s" dic change)
;;     ))

;; (global-set-key (kbd "<f8>") 'fd-switch-dictionary)

;;
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

;; CIDER choose REPL to evaluate against
(defun set-local-connection (conn)
  (interactive "bChoose connection: ")
  (if (with-current-buffer conn
        (derived-mode-p 'cider-repl-mode))
      (setq-local cider-connections (list conn))
    (message "not a connection buffer")))

;; Haskell
(add-hook 'haskell-mode-hook 'intero-mode)
;; the non-nil optional argument puts it after intero-mode
(add-hook 'haskell-mode-hook 'flymake-hlint-load  t)
;; (global-auto-complete-mode t)
(require 'haskell-align-imports)

;; Highlighting
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(mapc (lambda (mode)
        (add-to-list 'ahs-modes mode))
      '(clojure-mode clojurescript-mode cider-repl-mode haskell-mode javascript-mode))

(setq-default fill-column 80)

;; cljfmt
(defun cljfmt ()
  (when (or (eq major-mode 'clojure-mode)
            (eq major-mode 'clojurescript-mode))
    (shell-command-to-string (format "cljfmt %s" buffer-file-name))
    (revert-buffer :ignore-auto :noconfirm)))

;; (add-hook 'after-save-hook #'cljfmt)

(define-key global-map (kbd "s-`") 'other-frame)

;; (setq debug-on-error t)

;; Common Lisp

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; ;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")

(ido-vertical-mode 1)


;; https://queertypes.com/posts/34-purescript-emacs.html
(add-hook 'purescript-mode-hook 'turn-on-purescript-indentation)
(add-hook 'purescript-mode-hook 'flycheck-mode)

;; https://twitter.com/unlog1c/status/1051877170874904578
(setq-default ffap-machine-p-known 'reject)

;; shellcheck
(add-hook 'sh-mode-hook 'flycheck-mode)

;; fix path
(when (memq window-system '(mac ns))
  (setenv "SHELL" "/bin/zsh")
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH" "JAVA_HOME"))
  (exec-path-from-shell-setenv "PATH" (concat "/Users/borkdude/dev/clj-kondo" ":" (getenv "PATH")))
  (exec-path-from-shell-setenv "PATH" (concat (getenv "NVM_BIN") ":" (getenv "PATH"))))

(custom-set-variables
 '(show-trailing-whitespace t))

;; (load "~/Dropbox/dev/clojure/flycheck-clj-kondo/flycheck-clj-kondo.el")

;;;; Setting up flycheck clj-kondo -> joker chain
;; ensure that clj-kondo checkers are at front of checker list
;; (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
;;   (setq flycheck-checkers (cons checker (delq checker flycheck-checkers))))
;; clj-kondo calls joker after linting, even if there are errors
;; (dolist (checkers '((clj-kondo-clj . clojure-joker)
;;                     (clj-kondo-cljs . clojurescript-joker)
;;                     (clj-kondo-cljc . clojure-joker)
;;                     (clj-kondo-edn . edn-joker)))
;;   (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers))))

(menu-bar-mode 0)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(hyper z)] 'undo)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)
(global-set-key [(hyper x)] 'kill-region)

(add-hook 'rust-mode-hook #'lsp)

(add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))

(set-face-background 'default "grey15")
(set-face-attribute 'region nil :background "#666")
(print "Hello from personal/init.el")

(when (not window-system)
  (global-git-gutter-mode +1))

;; tramp
(setq tramp-terminal-type "tramp")
(when (string-equal "localhost:10.0" (getenv "DISPLAY"))
  (set-face-attribute 'default nil :height 94))

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

;; org-present

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))
;; vterm

;; https://stackoverflow.com/questions/9990370/how-to-disable-hl-line-feature-in-specified-mode
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'some-mode-hook (lambda () (setq global-hl-line-mode nil)))

(add-hook
 'vterm-mode-hook
 (lambda()
   (setq global-hl-line-mode nil)
   (setq show-trailing-whitespace nil)))

;; end vterm

;; clojure-lsp
;; see https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)


;; (progn
;;   (setq gc-cons-threshold (* 511 1024 1024))
;;   (setq gc-cons-percentage 0.5)
;;   (run-with-idle-timer 5 t #'garbage-collect)
;;   (setq garbage-collection-messages t))

;; (setq garbage-collection-messages t)
;; see https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      lsp-headerline-breadcrumb-enable nil
      ;; company-idle-delay 2
      lsp-idle-delay 0.05
      company-minimum-prefix-length 2
      lsp-lens-enable t
      lsp-enable-file-watchers nil
      lsp-file-watch-threshold 10000
      ;; lsp-signature-auto-activate nil
      lsp-clojure-custom-server-command '("/Users/borkdude/bin/clojure-lsp-dev")
      ;; lsp-diagnostics-provider :none
      lsp-enable-indentation nil ;; uncomment to use cider indentation instead of lsp
      ;; lsp-enable-completion-at-point nil ;; uncomment to use cider completion instead of lsp

      lsp-completion-provider :capf
      lsp-enable-on-type-formatting nil)
;; or just disable lsp-diagnostics-mode for a single buffer

;; (setq lsp-ui-peek-list-width 60
;;       lsp-ui-doc-enable nil
;;       ;; lsp-ui-doc-max-width 200
;;       ;; lsp-ui-doc-max-height 30
;;       ;; lsp-signature-auto-activate nil
;;       lsp-ui-peek-fontify 'always
;;       lsp-ui-sideline-show-code-actions nil)

(defun find-refs ()
  (interactive)
  (lsp-find-references t)
  )

(defun find-definition ()
  "Try to find definition of cursor via LSP otherwise fallback to cider."
  (interactive)
  (let ((cursor (point))
        (buffer (current-buffer)))
    (lsp-find-definition)
    (when (and (eq buffer (current-buffer))
               (eq cursor (point)))
      (cider-find-var))
    ))

(require 'clojure-mode)
(require 'cider)

(define-key clojure-mode-map (kbd "M-.") #'find-definition)
(define-key cider-mode-map (kbd "M-.") #'find-definition)
(define-key clojurec-mode-map (kbd "M-.") #'find-definition)
(define-key clojurescript-mode-map (kbd "M-.") #'find-definition)

;;;; Setting up flycheck clj-kondo -> joker chain
;; ensure that clj-kondo checkers are at front of checker list
;; (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
;;   (setq flycheck-checkers (cons checker (delq checker flycheck-checkers))))
;; ;; clj-kondo calls lsp after linting, even if there are errors
;; (dolist (checkers '((clj-kondo-clj . lsp)
;;                     (clj-kondo-cljs . lsp)
;;                     (clj-kondo-cljc . lsp)
;;                     (clj-kondo-edn . lsp)))
;;   (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers))))

;; end clojure-lsp

;; (setq clojure-align-separator 'entire)
(add-to-list 'interpreter-mode-alist '("bb" . clojure-mode))

;; (require 'neil)

(defun clerk-show ()
  (interactive)
  (save-buffer)
  (let
      ((filename
        (buffer-file-name)))
    (when filename
      (cider-interactive-eval
       (concat "(nextjournal.clerk/show! \"" filename "\")")))))

(define-key clojure-mode-map (kbd "<M-return>") 'clerk-show)

;; (require 'flycheck-yamllint)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

(global-set-key (kbd "H-`") 'other-frame)
(let ((frame (make-frame))
      (buf (find-file-noselect "/Users/borkdude/Dropbox/notes/worklog.org")))
  (switch-to-buffer buf))
(other-frame 1)

;; (cider-register-cljs-repl-type 'nbb "(+ 1 2 3)")

;; (defun mm/cider-connected-hook ()
;;   (when (eq 'nbb cider-cljs-repl-type)
;;     (setq-local cider-show-error-buffer nil)
;;     (cider-set-repl-type 'cljs)))

;; (add-hook 'cider-connected-hook #'mm/cider-connected-hook)

;; (with-eval-after-load 'cider
;;   (cider-register-cljs-repl-type 'nbb "(+ 1 2 3)")
;;   )

(defun ed/setup-js-and-typescript ()
  (interactive)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (lsp-mode)
  (flycheck-mode +1)
  ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (setq js-indent-level 2)
  (setq typescript-indent-level 2)
  (define-key js-mode-map (kbd "M-.") 'lsp-find-definition)
  (subword-mode +1)
  (yas-minor-mode-on))

(add-hook 'js-mode-hook #'ed/setup-js-and-typescript)

;; https://emacs.stackexchange.com/a/13096/22096
(defun my-reload-dir-locals-for-current-buffer ()
  "reload dir locals for the current buffer"
  (interactive)
  (let ((enable-local-variables :all))
    (hack-dir-local-variables-non-file-buffer)))

(set-mouse-color "white")

(require 'posframe)
(setq lsp-signature-function #'lsp-signature-posframe)

(defun homebrew-gcc-paths ()
  "Return GCC library paths from Homebrew installations.
Detects paths for gcc and libgccjit packages to be used in LIBRARY_PATH."
  (let* ((paths '())
         (brew-bin (or (executable-find "brew")
                       (let ((arm-path "/opt/homebrew/bin/brew")
                             (intel-path "/usr/local/bin/brew"))
                         (cond
                          ((file-exists-p arm-path) arm-path)
                          ((file-exists-p intel-path) intel-path))))))

    (when brew-bin
      ;; Get gcc paths.
      (let* ((gcc-prefix (string-trim
                          (shell-command-to-string
                           (concat brew-bin " --prefix gcc"))))
             (gcc-lib-current (expand-file-name "lib/gcc/current" gcc-prefix)))
        (push gcc-lib-current paths)

        ;; Find apple-darwin directory.
        (let* ((default-directory gcc-lib-current)
               (arch-dirs (file-expand-wildcards "gcc/*-apple-darwin*/*[0-9]")))
          (when arch-dirs
            (push (expand-file-name
                   (car (sort arch-dirs #'string>)))
                  paths))))

      ;; Get libgccjit paths
      (let* ((jit-prefix (string-trim
                          (shell-command-to-string
                           (concat brew-bin " --prefix libgccjit"))))
             (jit-lib-current (expand-file-name "lib/gcc/current" jit-prefix)))
        (push jit-lib-current paths)))

    (nreverse paths)))

(defun setup-macos-native-comp-library-paths ()
  "Set up LIBRARY_PATH for native compilation on macOS.
Includes Homebrew GCC paths and CommandLineTools SDK libraries."
  (let* ((existing-paths (split-string (or (getenv "LIBRARY_PATH") "") ":" t))
         (gcc-paths (homebrew-gcc-paths))
         (clt-paths '("/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"))
         (unique-paths (delete-dups
                        (append existing-paths gcc-paths clt-paths))))

    (setenv "LIBRARY_PATH" (mapconcat #'identity unique-paths ":"))))

;; Set up library paths for native compilation on macOS.
(when (eq system-type 'darwin)
  (setup-macos-native-comp-library-paths))

(global-unset-key (kbd "C-z"))
