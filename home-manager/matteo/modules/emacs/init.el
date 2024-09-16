; boostrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; initialize use-package on non-Linux platforms
(straight-use-package 'use-package)

;; install org mode very early to avoid issues
;; https://github.com/syl20bnr/spacemacs/issues/15896#issuecomment-1435776540
(use-package org
  :straight t)

(setq debug-on-error t)
(setq custom-file (concat user-emacs-directory "custom.el"))
(setq suggest-key-bindings nil)

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq electric-indent-mode nil)
(setq-default indent-tabs-mode nil) ;; <3 spaces

;; CamelCase movement
(global-subword-mode 1)

;; matching paren
(setq blink-matching-paren nil)

;; Typing yes/no is obnoxious when y/n will do
(setf use-short-answers t)

;; string casing
(use-package string-inflection
  :straight t)

;; keep folders clean
(use-package no-littering
  :straight t)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)
(add-hook 'meow-insert-exit-hook 'save-all)

;; UI stuff
(setq inhibit-startup-message t)
;; disable visible scrollbar
(scroll-bar-mode -1)
;; disable the toolbar
(tool-bar-mode -1)
;; disable tooltips
(tooltip-mode -1)
;; give some breathing room
(set-fringe-mode 10)
;; disable the menu bar
(menu-bar-mode -1)

;; set up the visible bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(column-number-mode)
(global-display-line-numbers-mode t)
(add-hook 'prog-mode-hook #'(lambda () (setq-local show-trailing-whitespace t)))

;; disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; font configuration
(defvar efs/default-font-size 110)
(defvar efs/default-variable-font-size 110)

;; make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

(set-face-attribute 'default nil :font "JetBrains Mono" :height efs/default-font-size)

;; set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height efs/default-font-size)

;; set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "JetBrains Mono" :height efs/default-variable-font-size :weight 'regular)

(use-package nerd-icons
  :straight t)

;; themes
(use-package catppuccin-theme
  :straight t)
  
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'frappe)
(catppuccin-reload)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))

(setq doom-modeline-time-icon t)
(setq doom-modeline-icon t)
(setq doom-modeline-buffer-file-name-style 'auto)
(setq doom-modeline-buffer-name t)
(setq doom-modeline-indent-info nil)
(setq doom-modeline-buffer-encoding t)
(setq doom-modeline-enable-word-count nil)

(use-package dashboard
  :straight t
  :config (dashboard-setup-startup-hook)
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-projects-backend 'projectile)
  (dashboard-footer-messages '("(╯°□°)╯︵ ┻━┻"))
  (dashboard-items '((recents  . 5)
                     (bookmarks . 5)
                     (projects . 5)
                     (agenda . 5)
                     (registers . 5))))

(use-package vterm
  :straight t)

(use-package multi-vterm
  :straight t
  :config
  (add-hook 'vterm-mode-hook
			(lambda ()
              (meow-insert))))

(use-package spinner
  :straight t)

(use-package eldoc
  :straight t)

(use-package rg
  :straight t)

(use-package wgrep
  :straight t)

;; whichkey
(use-package which-key
  :straight t
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; Autocomplete
(use-package corfu
  :straight t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary 'separator)   ;; Never quit at completion boundary
  (corfu-quit-no-match 'separator)      ;; Quit if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'directory)   ;; Preselect the first result if it's not a directory
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  :hook
  (prog-mode . corfu-mode)
  (lsp-mode . corfu-mode)
  (sql-interactive-mode . corfu-mode)
  (shell-mode . corfu-mode)
  (eshell-mode . corfu-mode)

  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `global-corfu-modes'.
  :init
  (global-corfu-mode))

(use-package marginalia
  :straight t
  :config
  (marginalia-mode))

(use-package embark
  :straight t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless partial-completion basic))
  (completion-category-defaults nil)
  (completion-category-overrides nil)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t))

(use-package cape
  :straight t
  :init
  (add-to-list 'completion-at-point-functions (cape-capf-super #'cape-dabbrev #'cape-keyword))
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package vertico
  :straight t
  :init
  (vertico-mode))

(use-package savehist
  :straight t
  :init
  (savehist-mode))

(use-package consult
  :straight t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.2
        register-preview-function #'consult-register-format))

(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

;; helpful
(use-package helpful
  :straight t
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; git
(use-package magit
  :straight t
                                        ; :init
                                        ; (setq magit-blame-styles '((margin
                                        ;      			(margin-format " %s%f" " %C %a" " %H")
                                        ;      			(margin-width . 42)
                                        ;      			(margin-face . magit-blame-margin)
                                        ;      			(margin-body-face magit-blame-dimmed))))
                                        ; (setq magit-blame-echo-style 'margin)
  :custom
                                        ; :hook (prog-mode . (lambda () (magit-blame-echo nil)))
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package diff-hl
  :straight t
  :after magit
  :init
  (global-diff-hl-mode)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; file tree navigation
(use-package dired
  :straight nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump)))

(setq dired-listing-switches "-lAXGh --group-directories-first")

;; LSP
(defun efs/lsp-mode-setup ()
  (setq lsp-modeline-diagnostic-scope :workspace)
  (setq lsp-modeline-code-actions-segment '(count icon))
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (setq lsp-headerline-breadcrumb-icons-enable nil)
  (lsp-headerline-breadcrumb-mode)
  (lsp-modeline-code-actions-mode)
  (lsp-modeline-diagnostics-mode))

(defun efs/lsp-completion-mode-setup ()
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
        '(flex)))

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook
  (lsp-mode . efs/lsp-mode-setup)
  (lsp-completion-mode . efs/lsp-completion-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  :custom
  (lsp-rust-server 'rust-analyzer)
  (rustic-lsp-server 'rust-analyzer)
  (lsp-rust-analyzer-cargo-watch-command "check")
  (lsp-rust-analyzer-experimental-proc-attr-macros t)
  (lsp-rust-analyzer-proc-macro-enable t)
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  (gc-cons-threshold 100000000)
  (read-process-output-max (* 1024 1024)) ;; 1mb
  (lsp-toggle-signature-auto-activate)
  (lsp-idle-delay 0.500)
  (lsp-progress-spinner-type 'moon)
  (lsp-elm-only-update-diagnostics-on-save t)
  (lsp-elm-disable-elmls-diagnostics t))

(global-set-key (kbd "C-c a") 'lsp-execute-code-action)
(global-set-key (kbd "C-c f") 'lsp-format-buffer)

(use-package lsp-haskell
  :straight t
  :hook
  (haskell-mode-hook . lsp)
  (haskell-literate-mode-hook . lsp))

(use-package lsp-ui
  :straight t
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-mode . lsp-ui-doc-mode)
  :custom
  (lsp-ui-doc-enable nil)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-show-code-actions nil))

(global-set-key (kbd "C-c k") 'lsp-ui-doc-glance)

(use-package flycheck
  :straight t
  :hook (prog-mode . flycheck-mode))

;; (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(use-package lsp-treemacs
  :straight t
  :after lsp)

(setq lsp-completion-provider :none)
(defun corfu-lsp-setup ()
  (setq-local completion-styles '(orderless)
              completion-category-defaults nil))
(add-hook 'lsp-mode-hook #'corfu-lsp-setup)

(use-package yasnippet
  :straight t
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/snippets"))
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

;; project management
(use-package projectile
  :straight t
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

(setq projectile-project-search-path (cddr (directory-files "~/Software" t)))
(setq shell-file-name "bash")

;; eye-candy
(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Programming Languages

;;; Rust

(use-package toml-mode
  :straight t
  :hook (toml-mode . lsp-deferred))

(use-package cargo
  :straight t
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :straight t
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package rust-mode
  :straight t
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rustic
  :straight (rustic :type git :host github :repo "emacs-rustic/rustic")
  :hook (rustic-mode . lsp-deferred)
  :config
  (setq rustic-spinner-type 'moon)
  (setq rustic-format-on-save t))

;;; Elixir
(use-package elixir-ts-mode
  :straight t
  :hook (elixir-ts-mode . lsp-deferred))

;;; Kotlin
(use-package kotlin-ts-mode
  :straight (:host gitlab :repo "bricka/emacs-kotlin-ts-mode")
  :mode "\\.kt\\'")

;;; GraphQL
(use-package graphql-mode
  :straight t)

;;; TypeScript
(use-package typescript-mode
  :straight t
  :hook (typescript-mode . lsp-deferred))

;;; SQL
(use-package sql
  :straight t
  :hook (sql-interactive-mode . toggle-truncate-lines)
  :config
  (setq sql-mysql-login-params (append sql-mysql-login-params '(port :default ,3306)))
  (setq sql-postgres-login-params (append sql-postgres-login-params '(port :default ,5432))))

;;; Markdown
(use-package markdown-mode
  :straight t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	     ("\\.md\\'" . markdown-mode)
	     ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;;; Elm
(use-package elm-mode
  :straight t
  :hook
  (elm-mode . lsp-deferred)
  (elm-mode . elm-format-on-save-mode))

;;; YAML
(use-package yaml-mode
  :straight t)

;;; Web stuff
(use-package web-mode
  :straight t
  :hook (web-mode . lsp-deferred))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.svelte?\\'" . web-mode))
(setq web-mode-enable-auto-pairing t)

;;; Tailwind
;; (straight-use-package
;;  '(lsp-tailwindcss :type git :host github :repo "merrickluo/lsp-tailwindcss"))

;;; Nix
(use-package nix-mode
  :straight t
  :mode "\\.nix\\'")

;;; Commenting
(use-package evil-nerd-commenter
  :straight t
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; Tools

;;; Multicursor

;;; Navigation
(use-package ace-jump-mode
  :straight t
  :bind ("C-c c SPC" . ace-jump-mode))

(use-package back-button
  :straight t
  :bind
  ("C-{" . back-button-local-backward)
  ("C-}" . back-button-local-forward)
  ("M-[" . back-button-global-backward)
  ("M-]" . back-button-global-forward))

(use-package ace-window
  :straight t
  :bind ([remap other-window] . ace-window))

;; Visd0m infinite wisdom functions
(defun visd0m/select-line ()
  "Select current line and leave the point at the end of the line."
  (interactive)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (move-end-of-line nil))

(defun visd0m/kill-buffer-file-truename ()
  "Kill current buffer file truename."
  (interactive)
  (if buffer-file-truename
      (kill-new buffer-file-truename)))

(defun visd0m/buffer-file-project-relative-name ()
  "Get current buffer file git project relative name or nil."
  (let ((project-root-dir (vc-root-dir))
        (absolute-name buffer-file-truename))
    (if (and project-root-dir absolute-name)
        (let ((project-relative-buffer-file-name (string-remove-prefix
                                                  project-root-dir
                                                  absolute-name)))
          project-relative-buffer-file-name)
      nil)))

(defun vid0m/backward-delete-word-no-kill (arg)
  "Delete characters backward until encountering the beginning of a word.
  With argument, do this that many times.
  This command does not push text to `kill-ring'."
  (interactive "p")
  (visd0m/delete-word-no-kill (- arg)))

(defun visd0m/delete-word-no-kill (arg)
  "Delete characters forward until encountering the end of a word.
  With argument, do this that many times.
  This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun visd0m/delete-line-no-kill ()
  "Delete the current line.
  This command does not push text to `kill-ring'."
  (interactive)
  (save-excursion
    (delete-region
     (progn (forward-visible-line 0) (point))
     (progn (forward-visible-line 1) (point)))))

(defun visd0m/lsp-kill-all ()
  "Kill all currenlty running processes considered lsp servers."
  (interactive)
  (seq-each (lambda (process-to-kill) (signal-process process-to-kill 15))
            (seq-filter
             'to-kill?
             (process-list))))

(defun to-kill?
    (process)
  (let ((process-name (process-name process)))
    (or
     (string-match "^rust-analyzer$" process-name)
     (string-match "^elixir-ls$" process-name)
     (string-match "^elm-ls$" process-name)
     (string-match "^iph$" process-name))))

(defun visd0m/upgrade-upgradable-packages ()
  "Upgrade upgradable packages using list-package and package menu."
  (interactive)
  (with-temp-buffer
    (list-packages)
    (package-refresh-contents)
    (package-menu-mark-upgrades)
    (package-menu-execute)
    (kill-buffer)))

(defun visd0m/psql-export-query-result-to-csv (query-to-execute csv-file-name)
  "Export result of 'QUERY-TO-EXECUTE to csv file 'CSV-FILE-NAME."
  (interactive "sQuery to execute: \nFFile path: ")
  (sql-send-string (format "\\copy (%s) to '%s' csv header" query-to-execute csv-file-name)))

(global-set-key (kbd "C-c c s") 'visd0m/select-line)
(global-set-key (kbd "M-<backspace>") 'vid0m/backward-delete-word-no-kill)
(global-set-key (kbd "C-<S-backspace>")
                'visd0m/delete-line-no-kill)
(global-set-key (kbd "C-x /") 'consult-ripgrep)

;;; Undo tree
(use-package undo-tree
  :straight t
  :init (global-undo-tree-mode)
  :bind ([remap upcase-region] . undo-tree-visualize)
  :config
  (setq undo-tree-auto-save-history nil))

;; Containers
(use-package kubectx-mode
  :straight t)

;; TreeSitter
;; (use-package tree-sitter
;;   :straight t)

;; (use-package tree-sitter-indent
;;   :straight t)

;; (use-package tree-sitter-langs
;;   :straight t)

;; (global-tree-sitter-mode)
;; (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; Modal editing
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("d" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet)
   '("/" . consult-line)
   '("p" . projectile-command-map)
   '("e" . lsp-treemacs-errors-list)
   '("w" . ace-window)
   '("j" . justl))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(use-package meow
  :straight t
  :config

  (meow-setup)
  (meow-global-mode 1)
  (setq meow-keypad-describe-delay 0.2)
  (setq meow-use-cursor-position-hack t)
  (setf meow-use-clipboard t))

(use-package scratch
  :straight t)


(use-package just-mode
  :straight t)


(use-package justl
  :straight t)

(use-package gdscript-mode
  :straight t
  :hook (web-mode . lsp-deferred)
  :config
  (setq gdscript-godot-executable "godot4"))

(use-package python-mode
  :straight t
  :hook (python-mode . lsp-deferred))

(use-package pyvenv
  :straight t
  :config
  (pyvenv-mode t)

  ;; Set correct Python interpreter
  (setq pyvenv-post-activate-hooks
        (list (lambda ()
                (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python3")))))
  (setq pyvenv-post-deactivate-hooks
        (list (lambda ()
                (setq python-shell-interpreter "python3")))))

(use-package terraform-mode
  :straight t)

(use-package go-mode
  :straight t
  :hook (go-mode . lsp-deferred))

;; (use-package blamer
;;   :straight t
;;   :bind (("s-i" . blamer-show-commit-info)
;;          ("C-c i" . blamer-show-posframe-commit-info))
;;   :defer 20
;;   :custom
;;   (blamer-idle-time 0.3)
;;   (blamer-min-offset 70)
;;   :custom-face
;;   (blamer-face ((t :foreground "#7a88cf"
;;                     :background nil
;;                     :height 120
;;                     :italic t)))
;;   :config
;;   (global-blamer-mode 1))

(use-package org-roam
  :straight t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :straight t)

(use-package protobuf-mode
  :straight t)

(use-package envrc
  :straight t)

(envrc-global-mode)
