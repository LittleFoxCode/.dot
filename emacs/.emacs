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

;; Language-modes

(use-package markdown-mode
  :ensure t
  )

(load-file "~/.dot/scripts/lyskom.el")

;; ;; Ellama
;; (use-package ellama
;;     :bind ("C-c e" . ellama-transient-main-menu)
;;     :init
;;     ;; setup key bindings
;;     ;; (setopt ellama-keymap-prefix "C-c e")
;;     ;; language you want ellama to translate to
;;     (setopt ellama-language "German")
;;     ;; could be llm-openai for example
;;     (require 'llm-ollama)
;;     (setopt ellama-provider
;; 	  (make-llm-ollama
;; 	       ;; this model should be pulled to use it
;; 	       ;; value should be the same as you print in terminal during pull
;; 	       :chat-model "llama3:8b"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("num_ctx" . 8192))))
;;     (setopt ellama-summarization-provider
;; 	      (make-llm-ollama
;; 	       :chat-model "qwen2.5:3b"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
;;     (setopt ellama-coding-provider
;; 	      (make-llm-ollama
;; 	       :chat-model "qwen2.5-coder:3b"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
;;     ;; Predefined llm providers for interactive switching.
;;     ;; You shouldn't add ollama providers here - it can be selected interactively
;;     ;; without it. It is just example.
;;     (setopt ellama-providers
;; 	      '(("zephyr" . (make-llm-ollama
;; 			     :chat-model "zephyr"
;; 			     :embedding-model "zephyr:7b-beta-q6_K"))
;; 		("mistral" . (make-llm-ollama
;; 			      :chat-model "mistral-nemo"
;; 			      :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
;; 		("mixtral" . (make-llm-ollama
;; 			      :chat-model "mixtral"
;; 			      :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))
;;     ;; Naming new sessions with llm
;;     (setopt ellama-naming-provider
;; 	      (make-llm-ollama
;; 	       :chat-model "llama3:8b"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("stop" . ("\n")))))
;;     (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
;;     ;; Translation llm provider
;;     (setopt ellama-translation-provider
;; 	    (make-llm-ollama
;; 	     :chat-model "qwen2.5:3b"
;; 	     :embedding-model "nomic-embed-text"
;; 	     :default-chat-non-standard-params
;; 	     '(("num_ctx" . 32768))))
;;     ;; customize display buffer behaviour
;;     ;; see ~(info "(elisp) Buffer Display Action Functions")~
;;     (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
;;     (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
;;     :config
;;     ;; send last message in chat buffer with C-c C-c
;;     (add-hook 'org-ctrl-c-ctrl-c-hook #'ellama-chat-send-last-message))


;;; That's all folks
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ellama markdown-mode zenburn-theme rainbow-delimiters magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
