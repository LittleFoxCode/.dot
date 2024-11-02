(setq inhibit-startup-message t)
(setq visible-bell t)
(setq show-paren-mode t)    ; I like to be able to see the matching parenthesis!
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Padding around frame edges
(menu-bar-mode -1)          ; Disable menu bar


(column-number-mode)        ; Show column on modeline
(global-display-line-numbers-mode t)   ; Activate linenumbers globally
(setq select-enable-clipboard t) ; Enalbes to paste from other window and vice versa.

;; Packages and package config
(require 'package)
 
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)

(setq package-enable-at-startup nil)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Themeing and colours
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; The GOAT of git interfaces
(use-package magit
  :ensure t
  :bind ("C-x g" . magit))

;;; That's all folks
