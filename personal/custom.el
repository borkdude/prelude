(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   '("2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" default))
 '(package-selected-packages
   '(prettier svelte-mode fold-this erlang prettier-js flycheck-yamllint dart-mode cider lsp-mode typescript-mode jdecomp zop-to-char zenburn-theme yaml-mode which-key vterm volatile-highlights use-package undo-tree super-save smex smartrep smartparens slim-mode sass-mode rvm rust-mode reveal-in-osx-finder rainbow-mode rainbow-delimiters purescript-mode projectile-rails org-present operate-on-number nlinum nix-mode neotree multi-term move-text markdown-toc magit lsp-treemacs json-mode js2-mode jedi inf-clojure imenu-anywhere ido-vertical-mode ido-completing-read+ hlint-refactor hl-todo haskell-mode guru-mode go-mode gitignore-mode gitconfig-mode git-timemachine git-modes git-gutter gist geiser flymake-hlint flycheck-rust flycheck-pos-tip flycheck-joker flycheck-inline flycheck-clj-kondo flx-ido expand-region exec-path-from-shell elisp-slime-nav editorconfig dockerfile-mode discover-my-major diminish diff-hl csv-mode crux company clj-refactor browse-kill-ring auto-highlight-symbol anzu anakondo ag adoc-mode))
 '(safe-local-variable-values
   '((cider-preferred-build-tool . "lein")
     (eval with-eval-after-load 'clojure-mode
           (define-clojure-indent
             (assoc 0)
             (ex-info 0)
             (for! 1)
             (for* 1)
             (js-for 1)
             (as-> 2)
             (flow 1)
             (if-ok-let 1)
             (when-ok-let 1)
             (nextjournal\.clerk/example 0)
             (nextjournal\.commands\.api/register! 1)
             (nextjournal\.commands\.api/register-context-fn! 1)
             (commands/register! 1)
             (q/register 1)
             (subs/register 1)
             (re-db\.query/register 1)))
     (eval put 'p/defprotocol+ 'clojure-doc-string-elt 2)
     (eval put 'mu/defn 'clojure-doc-string-elt 2)
     (eval put 'mi/define-batched-hydration-method 'clojure-doc-string-elt 3)
     (eval put 'mi/define-simple-hydration-method 'clojure-doc-string-elt 3)
     (eval put 'methodical/defmulti 'clojure-doc-string-elt 2)
     (eval put 'methodical/defmethod 'clojure-doc-string-elt 3)
     (eval put 'api/defendpoint-schema 'clojure-doc-string-elt 3)
     (eval put 'defendpoint-schema 'clojure-doc-string-elt 3)
     (eval define-clojure-indent
           (assoc 0)
           (ex-info 0))
     (clojure-dev-menu-name . "flow-storm-dev-menu")
     (eval
      (lambda nil
        (defun cider-test-run-project-tests-warning
            (orig-fun &rest args)
          (if
              (and
               (boundp 'disallow-cider-test-run-project-tests)
               disallow-cider-test-run-project-tests)
              (message "`cider-test-run-project-tests` should not be used on this project, please use `cider-test-run-loaded-tests` instead.")
            (apply orig-fun args)))
        (advice-add 'cider-test-run-project-tests :around #'cider-test-run-project-tests-warning)))
     (disallow-cider-test-run-project-tests . t)
     (cider-test-defining-forms)
     (eval with-eval-after-load 'lsp-mode
           (setq lsp-file-watch-ignored-directories
                 (cl-union lsp-file-watch-ignored-directories
                           '("[/\\\\]\\react-native\\'"))))
     (eval with-eval-after-load 'clojure-mode
           (define-clojure-indent
             (assoc 0)
             (ex-info 0)
             (for! 1)
             (for* 1)
             (js-for 1)
             (as-> 2)
             (flow 1)
             (if-ok-let 1)
             (when-ok-let 1)
             (nextjournal\.clerk/example 0)
             (nextjournal\.commands\.api/register! 1)
             (nextjournal\.commands\.api/register-context-fn! 1)
             (commands/register! 1)
             (q/register 1)
             (re-db\.query/register 1)))
     (eval progn
           (add-to-list 'safe-local-variable-values
                        '(cider-test-defining-forms))
           (setq cider-test-defining-forms
                 (seq-uniq
                  (append cider-test-defining-forms
                          '("defflow" "defflow-wrapped")))))
     (web-mode-markup-indent-offset . default-indent)
     (web-mode-css-indent-offset . default-indent)
     (web-mode-code-indent-offset . default-indent)
     (javascript-indent-level . default-indent)
     (css-indent-offset . default-indent)
     (default-indent . 2)
     (js2-mode-show-strict-warnings)
     (magit-save-repository-buffers . dontask)
     (frame-resize-pixelwise . t)
     (display-line-numbers-width-start . t)
     (add-to-list 'cljr-magic-require-namespaces
                  '("log" . "nextjournal.log"))
     (cider-save-file-on-load)
     (cider-print-fn . puget)
     (cider-auto-track-ns-form-changes)
     (eval progn
           (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
           (add-to-list 'cider-jack-in-nrepl-middlewares "shadow.cljs.devtools.server.nrepl/middleware"))
     (cider-repl-display-help-banner)
     (cljr-favor-prefix-notation)
     (eval define-clojure-indent
           (l/matcha
            '(1
              (:defn)))
           (l/matche
            '(1
              (:defn)))
           (p\.types/def-abstract-type
            '(1
              (:defn)))
           (p\.types/defprotocol+
            '(1
              (:defn)))
           (p\.types/defrecord+
            '(2 nil nil
                (:defn)))
           (p\.types/deftype+
            '(2 nil nil
                (:defn)))
           (p/def-map-type
            '(2 nil nil
                (:defn)))
           (p/defprotocol+
            '(1
              (:defn)))
           (p/defrecord+
            '(2 nil nil
                (:defn)))
           (p/deftype+
            '(2 nil nil
                (:defn)))
           (tools\.macro/macrolet
            '(1
              ((:defn))
              :form)))
     (eval put-clojure-indent 'u/strict-extend 1)
     (eval put-clojure-indent 'u/select-keys-when 1)
     (eval put-clojure-indent 'qp\.streaming/streaming-response 1)
     (eval put-clojure-indent 'prop/for-all 1)
     (eval put-clojure-indent 'mt/test-driver 1)
     (eval put-clojure-indent 'mt/test-drivers 1)
     (eval put-clojure-indent 'mt/query 1)
     (eval put-clojure-indent 'mt/format-rows-by 1)
     (eval put-clojure-indent 'mt/dataset 1)
     (eval put-clojure-indent 'mbql\.match/replace-in 2)
     (eval put-clojure-indent 'mbql\.match/replace 1)
     (eval put-clojure-indent 'mbql\.match/match-one 1)
     (eval put-clojure-indent 'mbql\.match/match 1)
     (eval put-clojure-indent 'match 1)
     (eval put-clojure-indent 'macros/case 0)
     (eval put-clojure-indent 'let-404 0)
     (eval put-clojure-indent 'impl/test-migrations 2)
     (eval put-clojure-indent 'db/update! 2)
     (eval put-clojure-indent 'db/insert-many! 1)
     (eval put-clojure-indent 'c/step 1)
     (eval put-clojure-indent 'api/let-404 1)
     (eval put 'p\.types/defprotocol+ 'clojure-doc-string-elt 2)
     (eval put 's/defn 'clojure-doc-string-elt 2)
     (eval put 'setting/defsetting 'clojure-doc-string-elt 2)
     (eval put 'defsetting 'clojure-doc-string-elt 2)
     (eval put 'api/defendpoint-async 'clojure-doc-string-elt 3)
     (eval put 'api/defendpoint 'clojure-doc-string-elt 3)
     (eval put 'define-premium-feature 'clojure-doc-string-elt 2)
     (eval put 'defendpoint-async 'clojure-doc-string-elt 3)
     (eval put 'defendpoint 'clojure-doc-string-elt 3)
     (ftf-project-finders ftf-get-top-git-dir)
     (eval
      (lambda nil
        (when
            (not
             (featurep 'nextjournal))
          (let
              ((init-file-path
                (expand-file-name "emacs.d/nextjournal.el" default-directory)))
            (when
                (file-exists-p init-file-path)
              (load init-file-path)
              (require 'nextjournal))))))
     (cider-refresh-after-fn . "com.nextjournal.journal.repl/post-refresh")
     (cider-refresh-before-fn . "com.nextjournal.journal.repl/pre-refresh")
     (prettify-symbols-mode)
     (eval when
           (and
            (buffer-file-name)
            (not
             (file-directory-p
              (buffer-file-name)))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (unless
               (featurep 'package-build)
             (let
                 ((load-path
                   (cons "../package-build" load-path)))
               (require 'package-build)))
           (unless
               (derived-mode-p 'emacs-lisp-mode)
             (emacs-lisp-mode))
           (package-build-minor-mode)
           (setq-local flycheck-checkers nil)
           (set
            (make-local-variable 'package-build-working-dir)
            (expand-file-name "../working/"))
           (set
            (make-local-variable 'package-build-archive-dir)
            (expand-file-name "../packages/"))
           (set
            (make-local-variable 'package-build-recipes-dir)
            default-directory))
     (eval
      (lambda nil
        (defun cider-jack-in-wrapper-function
            (orig-fun &rest args)
          (if
              (and
               (boundp 'use-bb-dev)
               use-bb-dev)
              (message "Use `bb dev` to start the development server, then `cider-connect` to the port it specifies.")
            (apply orig-fun args)))
        (advice-add 'cider-jack-in :around #'cider-jack-in-wrapper-function)
        (when
            (not
             (featurep 'clerk))
          (let
              ((init-file-path
                (expand-file-name "clerk.el" default-directory)))
            (when
                (file-exists-p init-file-path)
              (load init-file-path)
              (require 'clerk))))))
     (use-bb-dev . t)))
 '(scss-compile-at-save nil)
 '(show-trailing-whitespace t)
 '(slim-backspace-backdents-nesting nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t (:foreground "#D3D3D3")))))
