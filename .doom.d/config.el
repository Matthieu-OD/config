;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Matthieu Olenga-Disashi"
      user-mail-address "matt.olenga@gmail.com")

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
(setq
 projectile-project-search-path '("~/Documents/Programming/IT_Projects/")
 org-directory "~/Documents/org/")

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


;; Cursor
; Change the shape in insert mode
(setq evil-insert-state-cursor '(box))

;; Emacs-reveal
(use-package emacs-reveal
  :load-path "~/.emacs.d/elpa/emacs-reveal")
(setq oer-reveal-export-dir "./")

;; Emmet Mode
(setq emmet-self-closing-tag-style " /") ;; default "/"
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation
(setq emmet-expand-jsx-className? t) ;; default nil
(setq emmet-self-closing-tag-style " /") ;; default "/"

;; Emacs System

;relative Number
(setq-default display-line-numbers-type 'visual)

;transparency
(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
(add-to-list 'default-frame-alist '(alpha . (92 . 90)))

;; Org Mode
[after: org
        (map: map org-mode-map
              :n "M-j" #'org-metadown
              :n "M-j" #'org-metadown)]

;laTeX
(getenv "PATH")
 (setenv "PATH"
(concat
 "/Library/TeX/texbin/" ":"
(getenv "PATH")))

(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
(setq exec-path (append exec-path '("/Library/TeX/texbin")))

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(setq org-latex-toc-command "\\tableofcontents \\clearpage")

;org-roam
(setq org-roam-directory"~/Documents/org/myLifeOrganisation")
(add-to-list 'load-path "/home/guangzhi/.emacs.d/elisp/")

;org-super-agenda
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                        :time-grid t
                                        :scheduled today)
                                  (:name "Due today"
                                        :deadline today)
                                  (:name "Important"
                                        :priority "A")
                                  (:name "Overdue"
                                        :deadline past)
                                  (:name "Big Outcomes"
                                        :tag "bo")))
  :config
  (org-super-agenda-mode)
)

(use-package org-fancy-priorities
  :ensure t
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . "■")
                                    (?B . "■")
                                    (?C . "■"))))

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (setq org-agenda-skip-scheduled-if-done t
        org-log-done 'time
        org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "REPORT(r)" "CANCELLED(c)"))
        org-todo-keyword-faces
        '(("TODO" :foreground "#fad075" :weight normal :underline f)
          ("WAITING" :foreground "#60c2cc" :weight normal :underline f)
          ("INPROGRESS" :foreground "#0098dd" :weight normal :underline f)
          ("DONE" :foreground "#50a14f" :weight normal :underline f)
          ("REPORT" :foreground "#de7f2c" :weight normal :underline f)
          ("CANCELLED" :foreground "#ff6480" :weight normal :underline f))
        ;;org-agenda-files (list
        ;;      "~/org/myLifeOrganisation/2020/")
        )
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
)

;; Projectile
; Project search path
(setq projectile-project-search-path '("~/Documents/"))

;; Rjsx mode config
(use-package rjsx-mode
  :ensure t
  :mode "\\js\\'")
