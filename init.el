;;; init.el --- Personal Emacs configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;; Standalone config, migrated from Prelude. Uses use-package throughout.

;;; Code:

;; Performance: raise GC threshold during startup, restore after
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

;; Warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Always load newest byte code
(setq load-prefer-newer t)

;; Savefile directory for history, recentf, etc.
(defvar savefile-dir (expand-file-name "savefile" user-emacs-directory))
(unless (file-exists-p savefile-dir)
  (make-directory savefile-dir))

;; Custom file — keep customize junk out of init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;;; --- Package setup ---

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap use-package (built-in on Emacs 29+)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;;; --- Sane defaults ---

;; Tabs and indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)
(setq-default fill-column 80)
(setq tab-always-indent 'complete)

;; Files
(setq require-final-newline t)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; UI
(set-frame-font "Menlo" nil t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
;; (global-display-line-numbers-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                             (abbreviate-file-name (buffer-file-name))
                                           "%b"))))

;; Editing behavior
(delete-selection-mode t)
(global-auto-revert-mode t)
(setq blink-matching-paren nil)
(global-hl-line-mode +1)
(make-variable-buffer-local 'global-hl-line-mode)

;; Theme — load zenburn, then override background
(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))
(set-face-background 'default "grey15")
(set-face-attribute 'region nil :background "#666")
(set-mouse-color "white")

;; Enable commands disabled by default
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;; Remember cursor position
(setq save-place-file (expand-file-name "saveplace" savefile-dir))
(save-place-mode 1)

;; Save minibuffer history
(require 'savehist)
(setq savehist-additional-variables '(search-ring regexp-search-ring)
      savehist-autosave-interval 60
      savehist-file (expand-file-name "savehist" savefile-dir))
(savehist-mode +1)

;; Recent files
(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" savefile-dir)
      recentf-max-saved-items 500
      recentf-max-menu-items 15
      recentf-auto-cleanup 'never)
(recentf-mode +1)

;; Shift + arrow keys to switch windows
(windmove-default-keybindings)

;; Winner mode for window config undo
(winner-mode +1)

;; Whitespace
(require 'whitespace)
(setq whitespace-line-column 80
      whitespace-style '(face tabs empty trailing lines-tail))
(custom-set-variables '(show-trailing-whitespace t))

;; Dired
(put 'dired-find-alternate-file 'disabled nil)
(setq dired-recursive-deletes 'always
      dired-recursive-copies 'always
      dired-dwim-target t)
(require 'dired-x)

;; Ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Imenu
(set-default 'imenu-auto-rescan t)

;; Compilation
(setq compilation-ask-about-save nil
      compilation-always-kill t
      compilation-scroll-output 'first-error)
(require 'ansi-color)
(add-hook 'compilation-filter-hook
          (lambda ()
            (when (eq major-mode 'compilation-mode)
              (let ((inhibit-read-only t))
                (ansi-color-apply-on-region (point-min) (point-max))))))

;; .zsh files
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))

;; Make scripts executable on save
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Saner regex syntax
(setq reb-re-syntax 'string)

;; Eshell
(setq eshell-directory-name (expand-file-name "eshell" savefile-dir))

;; Tramp
(require 'tramp)
(setq tramp-default-method "ssh"
      tramp-terminal-type "tramp")

;; Bookmarks
(setq bookmark-default-file (expand-file-name "bookmarks" savefile-dir)
      bookmark-save-flag 1)

;; Hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Abbreviation mode in text
(add-hook 'text-mode-hook 'abbrev-mode)

;;;; --- macOS specific ---

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'hyper)
  (setq ns-function-modifier 'hyper)

  ;; Emoji support
  (when (fboundp 'set-fontset-font)
    (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend))

  ;; Hyper keybindings (Command key)
  (global-set-key [(hyper a)] 'mark-whole-buffer)
  (global-set-key [(hyper v)] 'yank)
  (global-set-key [(hyper c)] 'kill-ring-save)
  (global-set-key [(hyper s)] 'save-buffer)
  (global-set-key [(hyper l)] 'goto-line)
  (global-set-key [(hyper w)] (lambda () (interactive) (delete-window)))
  (global-set-key [(hyper z)] 'undo)
  (global-set-key [(hyper x)] 'kill-region)
  (global-set-key (kbd "H-`") 'other-frame))

;;;; --- Packages ---

;; diminish — hides minor mode names from the modeline to reduce clutter
(use-package diminish)

;; exec-path-from-shell — imports shell env vars (PATH, etc.) into GUI Emacs
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (setenv "SHELL" "/bin/zsh")
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("PATH" "JAVA_HOME"))
  (exec-path-from-shell-setenv "PATH"
    (concat "/Users/borkdude/dev/clj-kondo" ":" (getenv "PATH"))))

;; nvm — Node.js version manager integration
(use-package nvm
  :config
  (nvm-use "20")
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-setenv "PATH"
      (concat (getenv "NVM_BIN") ":" (getenv "PATH")))))

;; smartparens — structural editing (auto-close parens, slurp/barf, etc.)
(use-package smartparens
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (setq sp-base-key-bindings 'paredit
        sp-autoskip-closing-pair 'always
        sp-hybrid-kill-entire-symbol nil)
  (sp-use-paredit-bindings)
  ;; Fix M-s and M-? shadowing built-in bindings
  (define-key smartparens-mode-map (kbd "M-s") nil)
  (define-key smartparens-mode-map (kbd "M-?") nil)
  (show-smartparens-global-mode +1))

;; rainbow-delimiters — color-codes nested parens/brackets by depth
(use-package rainbow-delimiters)

;; Shared Lisp hook for all Lisp-like modes
(defun my-lisp-coding-hook ()
  "Enable smartparens-strict-mode and rainbow-delimiters."
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1))

;; projectile — project navigation (find file in project, grep, switch project)
(use-package projectile
  :diminish projectile-mode
  :init
  (setq projectile-cache-file (expand-file-name "projectile.cache" savefile-dir))
  :config
  (projectile-mode t)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; magit — Git porcelain (stage, commit, push, log, blame, etc.)
(use-package magit
  :bind (("C-c g" . magit-file-dispatch)))

;; flymake — built-in on-the-fly syntax checking (LSP feeds diagnostics into it)
(add-hook 'prog-mode-hook #'flymake-mode)

;; Show flymake error below the current line only, as inline overlay
(defvar-local my/flymake-inline-ov nil)

(defface my/flymake-inline-face
  '((t :foreground "#ffa500"))
  "Face for inline flymake diagnostics.")

(defun my/flymake-show-inline ()
  "Show flymake diagnostic at end of current line as an overlay."
  (when my/flymake-inline-ov
    (delete-overlay my/flymake-inline-ov)
    (setq my/flymake-inline-ov nil))
  (when-let* ((diags (flymake-diagnostics (line-beginning-position) (line-end-position))))
    (let* ((text (mapconcat #'flymake-diagnostic-text diags "; "))
           (ov (make-overlay (line-end-position) (line-end-position))))
      (overlay-put ov 'after-string
                   (propertize (concat "  " text) 'face 'my/flymake-inline-face))
      (overlay-put ov 'my-flymake-inline t)
      (setq my/flymake-inline-ov ov))))

(defun my/flymake-clear-inline ()
  "Remove inline diagnostic overlay."
  (when my/flymake-inline-ov
    (delete-overlay my/flymake-inline-ov)
    (setq my/flymake-inline-ov nil)))

(add-hook 'flymake-mode-hook
          (lambda ()
            (add-hook 'post-command-hook #'my/flymake-show-inline nil t)))

(add-hook 'flymake-mode-hook
          (lambda ()
            (add-hook 'before-revert-hook #'my/flymake-clear-inline nil t)))

;; corfu — lightweight auto-completion popup, uses Emacs's built-in completion-at-point
(use-package corfu
  :config
  (setq corfu-auto t           ;; show popup automatically
        corfu-auto-delay 0.5   ;; after 0.5s idle
        corfu-auto-prefix 2    ;; after typing 2 characters
        corfu-cycle t)
  (global-corfu-mode))

;; which-key — shows available keybindings when you pause mid-keystroke
(use-package which-key
  :diminish which-key-mode
  :config
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook 'which-key-mode)
    (which-key-mode +1)))

;; crux — collection of handy editing commands (duplicate line, rename file+buffer, etc.)
(use-package crux
  :bind (("C-c o" . crux-open-with)
         ("C-a" . crux-move-beginning-of-line)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c e" . crux-eval-and-replace)
         ("C-c s" . crux-swap-windows)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c d" . crux-duplicate-current-line-or-region)
         ("C-c M-d" . crux-duplicate-and-comment-current-line-or-region)
         ("C-c r" . crux-rename-buffer-and-file)
         ("C-c k" . crux-kill-other-buffers)
         ("C-c I" . crux-find-user-init-file)
         ("C-<backspace>" . crux-kill-line-backwards)
         ([remap kill-whole-line] . crux-kill-whole-line)
         ([(shift return)] . crux-smart-open-line)
         ("M-o" . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above))
  :config
  (crux-with-region-or-line kill-region))

;; ace-window — jump to any window by number (shows big numbers in each window)
(use-package ace-window
  :bind (("s-w" . ace-window)
         ([remap other-window] . ace-window)))

;; expand-region — progressively expand selection (word -> expression -> block -> ...)
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; move-text — move current line or region up/down with a keystroke
(use-package move-text
  :bind (([(control shift up)] . move-text-up)
         ([(control shift down)] . move-text-down)
         ([(meta shift up)] . move-text-up)
         ([(meta shift down)] . move-text-down)))

;; vundo — visual undo tree browser (lighter than undo-tree, no corruption issues)
;; Press C-x u to open the tree, navigate with f/b/n/p, press q to quit
(use-package vundo
  :bind ("C-x u" . vundo))

;; diff-hl — highlights uncommitted changes in the gutter (git diff in the fringe)
(use-package diff-hl
  :config
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; super-save — auto-saves buffers when you switch windows/buffers
(use-package super-save
  :diminish super-save-mode
  :config
  (add-to-list 'super-save-triggers 'ace-window)
  (super-save-mode +1))

;; editorconfig — applies per-project editor settings from .editorconfig files
(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

;; hl-todo — highlights TODO, FIXME, HACK etc. in code comments
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))


;; vertico — vertical completion UI, builds on Emacs's native completing-read
(use-package vertico
  :config
  (vertico-mode +1)
  (setq vertico-cycle t)
  (set-face-attribute 'vertico-current nil
                      :underline nil
                      :background "#444"))

;; prescient — sorts candidates by frequency and recency (recently used first)
(use-package vertico-prescient
  :after vertico
  :config
  (setq vertico-prescient-enable-filtering nil) ;; use orderless for filtering
  (vertico-prescient-mode +1)
  (prescient-persist-mode +1))

;; orderless — flexible matching (type words in any order, e.g. "clj def" finds clojure-find-definition)
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
  (setq orderless-matching-styles '(orderless-literal orderless-regexp orderless-initialism)))

;; marginalia — shows descriptions next to candidates (docstrings, file info, etc.)
(use-package marginalia
  :config
  (marginalia-mode +1))

;; consult — enhanced search, buffer switch, recent files, grep, and more
(use-package consult
  :bind (("C-c f" . consult-recent-file)
         ("C-x b" . consult-buffer)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("C-x C-m" . execute-extended-command)))

;; git-gutter — shows git diff markers in the gutter (terminal only, diff-hl handles GUI)
(use-package git-gutter
  :if (not window-system)
  :config
  (global-git-gutter-mode +1))

;; posframe — show child frames at point (used for LSP signature help popups)
(use-package posframe
  :config
  (setq lsp-signature-function #'lsp-signature-posframe))

;; auto-highlight-symbol — highlights all occurrences of symbol under cursor
(use-package auto-highlight-symbol
  :config
  (global-auto-highlight-symbol-mode t)
  (mapc (lambda (mode)
          (add-to-list 'ahs-modes mode))
        '(clojure-mode clojurescript-mode cider-repl-mode
          haskell-mode javascript-mode)))

;;;; --- LSP ---

;; lsp-mode — Language Server Protocol client (code intel, diagnostics, formatting)
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-headerline-breadcrumb-enable nil
        lsp-idle-delay 0.05
        lsp-lens-enable t
        lsp-enable-file-watchers nil
        lsp-file-watch-threshold 10000
        lsp-clojure-custom-server-command '("/Users/borkdude/bin/clojure-lsp-dev")
        lsp-enable-indentation nil
        lsp-completion-provider :capf
        lsp-enable-on-type-formatting nil
        lsp-enable-snippet nil)
  (add-hook 'lsp-after-apply-edits-hook (lambda (&rest _) (save-buffer))))

;;;; --- Programming base hook ---

(defun my-prog-mode-hook ()
  "Shared hook for all programming modes."
  (smartparens-mode +1)
  (which-function-mode))

(add-hook 'prog-mode-hook #'my-prog-mode-hook)

;;;; --- Language modes ---

;; Clojure
(use-package clojure-ts-mode
  :mode (("\\.clj\\'" . clojure-ts-mode)
         ("\\.cljc\\'" . clojure-ts-clojurec-mode)
         ("\\.cljs\\'" . clojure-ts-clojurescript-mode)
         ("\\.edn\\'" . clojure-ts-mode))
  :interpreter ("bb" . clojure-ts-mode)
  :hook ((clojure-ts-mode . lsp)
         (clojure-ts-mode . my-lisp-coding-hook)
         (clojure-ts-mode . subword-mode)))

;; Remap legacy clojure modes to tree-sitter variants
(add-to-list 'major-mode-remap-alist '(clojure-mode . clojure-ts-mode))
(add-to-list 'major-mode-remap-alist '(clojurescript-mode . clojure-ts-clojurescript-mode))
(add-to-list 'major-mode-remap-alist '(clojurec-mode . clojure-ts-clojurec-mode))

(use-package cider
  :after clojure-ts-mode
  :config
  (define-key clojure-mode-map (kbd "M-.") #'find-definition)
  (define-key cider-mode-map (kbd "M-.") #'find-definition)
  (define-key clojurec-mode-map (kbd "M-.") #'find-definition)
  (define-key clojurescript-mode-map (kbd "M-.") #'find-definition)

  ;; Clerk
  (cider-register-cljs-repl-type 'clerk-browser-repl "(+ 1 2 3)"))

(defun find-definition ()
  "Try to find definition of cursor via LSP otherwise fallback to cider."
  (interactive)
  (let ((cursor (point))
        (buffer (current-buffer)))
    (lsp-find-definition)
    (when (and (eq buffer (current-buffer))
               (eq cursor (point)))
      (cider-find-var))))

(defun find-refs ()
  (interactive)
  (lsp-find-references t))

(defun mm/cider-connected-hook ()
  (when (eq 'clerk-browser-repl cider-cljs-repl-type)
    (setq-local cider-show-error-buffer nil)
    (cider-set-repl-type 'cljs)))

(add-hook 'cider-connected-hook #'mm/cider-connected-hook)

(defun clerk-show ()
  (interactive)
  (save-buffer)
  (let ((filename (buffer-file-name)))
    (when filename
      (cider-interactive-eval
       (concat "(nextjournal.clerk/show! \"" filename "\")")))))

;; JavaScript / TypeScript (tree-sitter)
(setq treesit-language-source-alist
      '((javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (css "https://github.com/tree-sitter/tree-sitter-css")))

(add-to-list 'auto-mode-alist '("\\.m?js\\'" . js-ts-mode))
(add-to-list 'interpreter-mode-alist '("node" . js-ts-mode))

(add-hook 'js-ts-mode-hook #'lsp)
(add-hook 'js-ts-mode-hook
          (lambda ()
            (eldoc-mode +1)
            (setq js-indent-level 2)
            (setq typescript-indent-level 2)
            (subword-mode +1)))

;; CSS
(use-package rainbow-mode
  :hook (css-mode . rainbow-mode))

(setq css-indent-offset 2)

;; Rust
(use-package rust-mode
  :hook (rust-mode . lsp))


;; elisp-slime-nav — M-. to jump to definition, M-, to jump back in Emacs Lisp
(use-package elisp-slime-nav
  :diminish elisp-slime-nav-mode
  :hook ((emacs-lisp-mode . elisp-slime-nav-mode)
         (ielm-mode . elisp-slime-nav-mode)))

(add-hook 'emacs-lisp-mode-hook #'my-lisp-coding-hook)
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-mode)

;; Shell — recognize Prezto/Zsh config files
(add-to-list 'auto-mode-alist '("zlogin\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zlogout\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zpreztorc\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zprofile\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zshenv\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zshrc\\'" . shell-script-mode))


;; XML
(add-to-list 'auto-mode-alist '("\\.pom\\'" . nxml-mode))
(setq nxml-child-indent 4
      nxml-attribute-indent 4)

;; Org
(use-package org
  :ensure nil
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :config
  (setq org-log-done t))

(use-package org-present
  :config
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
              (org-present-read-write))))

;; Adoc mode
(add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))

;; Markdown
(use-package markdown-mode)
(use-package markdown-toc)

;;;; --- Terminal ---

;; vterm — full terminal emulator inside Emacs (faster than term/ansi-term)
(use-package vterm
  :hook (vterm-mode . (lambda ()
                        (setq global-hl-line-mode nil)
                        (setq show-trailing-whitespace nil))))

;; Mouse in terminal
(unless window-system
  (xterm-mouse-mode t))

;;;; --- Personal functions ---

(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (if (and (lsp-workspaces)
           (lsp--capability "documentFormattingProvider"))
      (lsp-format-buffer)
    (indent-region (point-min) (point-max) nil))
  (untabify (point-min) (point-max)))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun set-local-connection (conn)
  "Choose CIDER REPL connection for current buffer."
  (interactive "bChoose connection: ")
  (if (with-current-buffer conn
        (derived-mode-p 'cider-repl-mode))
      (setq-local cider-connections (list conn))
    (message "not a connection buffer")))

(defun cljfmt ()
  (when (or (eq major-mode 'clojure-mode)
            (eq major-mode 'clojurescript-mode))
    (shell-command-to-string (format "cljfmt %s" buffer-file-name))
    (revert-buffer :ignore-auto :noconfirm)))

(defun my-reload-dir-locals-for-current-buffer ()
  "Reload dir locals for the current buffer."
  (interactive)
  (let ((enable-local-variables :all))
    (hack-dir-local-variables-non-file-buffer)))

(defun split-string-at-point ()
  "Split the string at point into two quoted strings."
  (interactive)
  (when (nth 3 (syntax-ppss))
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

(defun tt-dont-suspend-emacs ()
  (interactive)
  (message "Not suspending emacs"))

(defun homebrew-gcc-paths ()
  "Return GCC library paths from Homebrew installations."
  (let* ((paths '())
         (brew-bin (or (executable-find "brew")
                       (let ((arm-path "/opt/homebrew/bin/brew")
                             (intel-path "/usr/local/bin/brew"))
                         (cond
                          ((file-exists-p arm-path) arm-path)
                          ((file-exists-p intel-path) intel-path))))))
    (when brew-bin
      (let* ((gcc-prefix (string-trim
                          (shell-command-to-string
                           (concat brew-bin " --prefix gcc"))))
             (gcc-lib-current (expand-file-name "lib/gcc/current" gcc-prefix)))
        (push gcc-lib-current paths)
        (let* ((default-directory gcc-lib-current)
               (arch-dirs (file-expand-wildcards "gcc/*-apple-darwin*/*[0-9]")))
          (when arch-dirs
            (push (expand-file-name (car (sort arch-dirs #'string>))) paths))))
      (let* ((jit-prefix (string-trim
                          (shell-command-to-string
                           (concat brew-bin " --prefix libgccjit"))))
             (jit-lib-current (expand-file-name "lib/gcc/current" jit-prefix)))
        (push jit-lib-current paths)))
    (nreverse paths)))

(defun setup-macos-native-comp-library-paths ()
  "Set up LIBRARY_PATH for native compilation on macOS."
  (let* ((existing-paths (split-string (or (getenv "LIBRARY_PATH") "") ":" t))
         (gcc-paths (homebrew-gcc-paths))
         (clt-paths '("/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"))
         (unique-paths (delete-dups (append existing-paths gcc-paths clt-paths))))
    (setenv "LIBRARY_PATH" (mapconcat #'identity unique-paths ":"))))

(when (eq system-type 'darwin)
  (setup-macos-native-comp-library-paths))

;;;; --- Global keybindings ---

(global-set-key (kbd "<f7>") 'iwb)
(global-set-key (kbd "<f9>") 'profiler-start)
(global-set-key (kbd "<f10>") 'profiler-stop)
(global-set-key (kbd "<f12>") 'menu-bar-mode)
(global-set-key (kbd "C-z") 'tt-dont-suspend-emacs)
(global-set-key (kbd "C-x C-z") 'tt-dont-suspend-emacs)
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "s-`") 'other-frame)

;; Clerk keybinding (set after clojure-mode loads)
(with-eval-after-load 'clojure-mode
  (define-key clojure-mode-map (kbd "<M-return>") 'clerk-show))

;;;; --- Emacs server ---

(require 'server)
(unless (server-running-p)
  (server-start))

;; emacsclient filename:linenumber support
(defadvice server-visit-files (before parse-numbers-in-lines (files proc &optional nowait) activate)
  "Open file with emacsclient with cursors positioned on requested line."
  (ad-set-arg 0
              (mapcar (lambda (fn)
                        (let ((name (car fn)))
                          (if (string-match "^\\(.*?\\):\\([0-9]+\\)\\(?::\\([0-9]+\\)\\)?$" name)
                              (cons
                               (match-string 1 name)
                               (cons (string-to-number (match-string 2 name))
                                     (string-to-number (or (match-string 3 name) ""))))
                            fn))) files)))

;;;; --- TRAMP display ---

(when (string-equal "localhost:10.0" (getenv "DISPLAY"))
  (set-face-attribute 'default nil :height 94))

;;;; --- Prevent ffap from pinging hostnames ---

(setq-default ffap-machine-p-known 'reject)

;;;; --- PureScript ---

;;;; --- Inf-clojure ---

;; inf-clojure — lightweight Clojure REPL (alternative to CIDER, e.g. for babashka)
(use-package inf-clojure
  :defer t)

;;;; --- Reveal in Finder ---

;; reveal-in-osx-finder — open current file's location in macOS Finder
(use-package reveal-in-osx-finder
  :if (eq system-type 'darwin))

;;; init.el ends here
