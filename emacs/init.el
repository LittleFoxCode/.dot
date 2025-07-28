;; Straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Package includes
(straight-use-package 'zenburn-theme)
(straight-use-package 'gptel)
(straight-use-package 'markdown-mode)
(straight-use-package 'which-key)

(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)
(straight-use-package 'typescript-mode)
(straight-use-package 'company)
(straight-use-package 'flycheck)

(straight-use-package 'magit)


;; Cosmetics
(setq visible-bell t)
(setq show-paren-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(column-number-mode)
(global-display-line-numbers-mode t)

(load-theme 'zenburn t)

;; System interaction
(setq select-enable-clipboard t) ; Enables pasting from other windows and vice versa.
(which-key-mode t)
(global-flycheck-mode)


;; AI and RAG

;; GPTel
;;; Keybinds
(global-set-key (kbd "C-c g") 'gptel-menu)
;; Register the backend
(gptel-make-ollama "Ollama"             ;Any name of your choosing
  :host "localhost:11434"               ;Where it's running
  :stream t                             ;Stream responses
  :models '(qwen2.5:14b, deepseek-r1:8b, gemma3:12b))               ;List of models

;; Make backend and model default
(setq
 gptel-model 'qwen2.5:14b
 gptel-backend (gptel-make-ollama "qwen2.5"
                 :host "localhost:11434"
                 :stream t
                 :models '(qwen2.5:14b)))

(setq
 gptel-model 'deepseek-r1:14b
 gptel-backend (gptel-make-ollama "deepseek-r1"
                 :host "localhost:11434"
                 :stream t
                 :models '(deepseek-r1:14b)))

(setq
 gptel-model 'gemma3:12b
 gptel-backend (gptel-make-ollama "gemma3"
                 :host "localhost:11434"
                 :stream t
                 :models '(gemma3:12b)))

;; Set the GPTel response buffer's major mode to `markdown-mode'.
(defun gptel-set-response-buffer-major-mode ()
  "Set the GPTel response buffer's major mode to `markdown-mode'."
  (setq gptel-response-buffer-name "*gptel-response*")
  (add-hook 'gptel-after-send-message-functions
            (lambda ()
              (with-current-buffer gptel-response-buffer-name
                (unless (derived-mode-p 'markdown-mode)
                  (markdown-mode))))))

(gptel-set-response-buffer-major-mode)

;; Programming languages and LSP

;; LSP
(setq lsp-enable-indentation t)
(setq lsp-prefer-flymake nil)

;; Company
(defun setup-lsp-and-company ()
  "Setup `lsp-mode` and `company-mode` for a buffer."
  (lsp-deferred)
  (setq-local company-backends '((company-capf :with company-yasnippet)))
  (add-hook 'typescript-mode-hook #'setup-lsp-and-company))


;; Typescript
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-hook 'typescript-mode-hook #'setup-lsp-and-company)
(add-hook 'web-mode-hook (lambda ()
                           (when (string-equal "tsx" (file-name-extension buffer-file-name))
                             (setup-lsp-and-company))))

(defun my-typescript-format-on-save ()
  "Format TypeScript files on save."
  (add-hook 'before-save-hook #'lsp-format-buffer t t))

(add-hook 'typescript-mode-hook #'my-typescript-format-on-save)

;; GIT

(global-set-key (kbd "C-x g") 'magit)
