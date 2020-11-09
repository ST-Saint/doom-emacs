;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "ST-Saint"
      user-mail-address "st.saint.wyy@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setenv "http_proxy" "http://127.0.0.1:2334")
(setenv "https_proxy" "http://127.0.0.1:2334")

(use-package! winum)
(setq! winum-mode t)

(use-package! vterm)
(use-package! rtags)
(use-package! vlf)

(setq which-key-mode t)

(setq global-visual-line-mode t)
(setq global-whitespace-newline-mode t)

(setq! projectile-sort-order 'recently-active)

(setq vc-handled-backends nil)
(setq magit-refresh-status-buffer nil)
(setq auto-revert-buffer-list-filter 'magit-auto-revert-repository-buffer-p)
(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
(remove-hook 'server-switch-hook 'magit-commit-diff)
(setq magit-diff-highlight-indentation' nil)
(setq magit-diff-highlight-trailing 'nil)
(setq magit-diff-paint-whitespace 'nil)
(setq magit-diff-highlight-hunk-body 'nil)
(setq magit-diff-refine-hunk 'nil)

(setq scroll-margin 5)

(map! :leader
      "0" #'treemacs-select-window
      "1" #'winum-select-window-1
      "2" #'winum-select-window-2
      "3" #'winum-select-window-3
      "4" #'winum-select-window-4
      )

(setq-default fill-column 999)
(setq-default global-hl-fill-column-mode 'nil)
(setq-default hl-fill-column-mode 'nil)

(setq! org-log-done 'time)
(setq doom-font (font-spec :family "Source Code Pro" :size 16));; :weight 'bold))
(setq lsp-before-save-edits t)
(setq! tramp-inline-compress-start-size 102400)

(map! :leader "p %" #'projectile-replace-regexp)
(map! :leader "m c l" #'mc/edit-lines)
(map! :leader "m c r" #'mc/mark-all-in-region-regexp)

(map! :nvei "C-c <C-right>" #'centaur-tabs-forward)
(map! :nvei "C-c <C-left>" #'centaur-tabs-backward)
(map! :eni "C-d" #'delete-char)
(map! :nv "C-e" #'end-of-line)
(map! :nv "C-a" #'beginning-of-line)
(map! :nv "C-y" #'evil-paste-after)
(map! :i "C-y" #'evil-paste-before)
(map! :nvi "C-n" #'next-line)
(map! :nvi "C-p" #'previous-line)
(map! :nvei "C-k" #'evil-delete-line)
(map! :nvei "C-t" #'transpose-chars)
(map! :nvei "<C-tab> " #'centaur-tabs-forward)
(map! :nvei "<C-iso-lefttab>" #'centaur-tabs-backward)

;; (add-hook! 'prog-mode-hook 'visual-line-mode)
(add-hook! 'prog-mode-hook 'lsp)
(add-hook! 'prog-mode-hook '+word-wrap-mode)
(add-hook! 'prog-mode-hook 'which-function-mode)
(add-hook! 'before-save-hook 'whitespace-cleanup)
(add-hook! 'before-save-hook #'+format/buffer nil t)

(setq ivy-count-format "(%d/%d) ")

(use-package! lsp-mode
  :custom
  (lsp-enable-snippet t)

  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection
                                     "clangd")
                    :major-modes '(c-mode c++-mode)
                    :remote? t
                    :server-id 'clangd-remote))
  )
