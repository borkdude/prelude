;;; package --- My own config

;;; Commentary:
;;; My config
(set-frame-font "Menlo" nil t)

;;; Code:
(prelude-require-packages '(markdown-mode
                            inf-clojure
                            flycheck-pos-tip
                            neotree
                            auto-highlight-symbol
                            haskell-mode
                            flymake-hlint
                            hlint-refactor
                            adoc-mode
                            ido-vertical-mode
                            purescript-mode
                            reveal-in-osx-finder
                            exec-path-from-shell
                            flycheck-rust
                            rust-mode
                            lsp-mode
                            git-gutter
                            flycheck-inline
                            org-present
                            vterm
                            markdown-toc
                            nvm
                            posframe
                            eca
                            clojure-ts-mode))

(nvm-use "20")

(require 'flycheck-rust)

;; window size on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(require 'lsp)

(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (if (and (lsp-workspaces)
           (lsp--capability "documentFormattingProvider")
           )
    (indent-region (point-min) (point-max) nil))
  (untabify (point-min) (point-max)))

(global-set-key (kbd "<f7>") 'iwb)

(global-set-key (kbd "<f9>") 'profiler-start)
(global-set-key (kbd "<f10>") 'profiler-stop)

(visual-line-mode)

;; Don't show whitespace
(setq prelude-whitespace nil)
;; Do not warn about arrow keys
(setq prelude-guru nil)

;; tree-sitter grammar sources
(setq treesit-language-source-alist
      '((javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (css "https://github.com/tree-sitter/tree-sitter-css")))

;; use tree-sitter modes instead of legacy modes
(add-to-list 'auto-mode-alist '("\\.m?js\\'" . js-ts-mode))
(add-to-list 'interpreter-mode-alist '("node" . js-ts-mode))

;; emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; neotree
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

;; flyspell
(setq prelude-flyspell nil)

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
(add-hook 'haskell-mode-hook 'flymake-hlint-load)
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

(define-key global-map (kbd "s-`") 'other-frame)

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

(when (not window-system)
  (global-git-gutter-mode +1))

;; tramp
(setq tramp-terminal-type "tramp")
(when (string-equal "localhost:10.0" (getenv "DISPLAY"))
  (set-face-attribute 'default nil :height 94))

(unless window-system
  (xterm-mouse-mode t))

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
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)

(add-hook
 'vterm-mode-hook
 (lambda()
   (setq global-hl-line-mode nil)
   (setq show-trailing-whitespace nil)))

;; clojure-lsp
;; see https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/

;; clojure-ts-mode: use instead of clojure-mode
(add-to-list 'major-mode-remap-alist '(clojure-mode . clojure-ts-mode))
(add-to-list 'major-mode-remap-alist '(clojurescript-mode . clojure-ts-clojurescript-mode))
(add-to-list 'major-mode-remap-alist '(clojurec-mode . clojure-ts-clojurec-mode))

;; clojure-ts-mode: enable smartparens + LSP (same as clojure-mode)
(add-hook 'clojure-ts-mode-hook (lambda () (run-hooks 'prelude-lisp-coding-hook)))
(add-hook 'clojure-ts-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      lsp-headerline-breadcrumb-enable nil
      lsp-idle-delay 0.05
      company-minimum-prefix-length 2
      lsp-lens-enable t
      lsp-enable-file-watchers nil
      lsp-file-watch-threshold 10000
      lsp-clojure-custom-server-command '("/Users/borkdude/bin/clojure-lsp-dev")
      lsp-enable-indentation nil
      lsp-completion-provider :capf
      lsp-enable-on-type-formatting nil)

(add-hook 'lsp-after-apply-edits-hook (lambda (&rest _) (save-buffer)))

(defun find-refs ()
  (interactive)
  (lsp-find-references t))

(defun find-definition ()
  "Try to find definition of cursor via LSP otherwise fallback to cider."
  (interactive)
  (let ((cursor (point))
        (buffer (current-buffer)))
    (lsp-find-definition)
    (when (and (eq buffer (current-buffer))
               (eq cursor (point)))
      (cider-find-var))))

(require 'cider)

(define-key clojure-mode-map (kbd "M-.") #'find-definition)
(define-key cider-mode-map (kbd "M-.") #'find-definition)
(define-key clojurec-mode-map (kbd "M-.") #'find-definition)
(define-key clojurescript-mode-map (kbd "M-.") #'find-definition)

(add-to-list 'interpreter-mode-alist '("bb" . clojure-mode))

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

(global-set-key (kbd "H-`") 'other-frame)
;; (let ((frame (make-frame))
;;       (buf (find-file-noselect "/Users/borkdude/Dropbox/notes/worklog.org")))
;;   (switch-to-buffer buf))
;; (other-frame 1)

(add-hook 'js-ts-mode-hook #'lsp)
(add-hook 'js-ts-mode-hook (lambda ()
                             (flycheck-mode +1)
                             (eldoc-mode +1)
                             (setq js-indent-level 2)
                             (setq typescript-indent-level 2)
                             (subword-mode +1)))

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

(defun tt-dont-suspend-emacs ()
  (interactive)
  (message "Not suspending emacs"))
(global-set-key (kbd "C-z") 'tt-dont-suspend-emacs)
(global-set-key (kbd "C-x C-z") 'tt-dont-suspend-emacs)

(defun split-string-at-point ()
  "Split the string at point into two quoted strings, keeping syntax correct."
  (interactive)
  (when (nth 3 (syntax-ppss))  ; are we inside a string?
    (insert "\"\"")
    (backward-char 1)))

(defun parmezan ()
  "Run parmezan on the current buffer."
  (interactive)
  (when (buffer-file-name)
    (save-buffer)
    (shell-command (format "parmezan --file %s --write"
                           (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t)))

(setq eca-custom-command (list (expand-file-name "~/.emacs.d/eca/eca") "server"))
;; run eca-install-server to get newest
