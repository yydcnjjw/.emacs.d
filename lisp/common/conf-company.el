(require-package 'company)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-backends '(company-files
                           company-keywords
                           company-abbrev
                           company-dabbrev-code
                           company-dabbrev)))
(add-hook 'after-init-hook #'global-company-mode)

(defun my/local-push-company-backend (backend)
  (make-local-variable 'company-backends)
  (push backend company-backends))

(require-package 'company-quickhelp)
(company-quickhelp-mode)

(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'flycheck)

;; disable flymake at lsp-mode
(setq lsp-prefer-flymake nil
      lsp-auto-configure nil)

(defun my/enable-lsp-ui()
  (lsp-ui-mode 1)
  (require 'lsp-ui-flycheck)
  (lsp-ui-flycheck-enable t)
  (flycheck-mode 1)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(defun my/configure-lsp-company ()
  (require-package 'company-lsp)
  (my/local-push-company-backend 'company-lsp))

(defun my/lsp-enable ()
  (interactive)
  (require 'lsp-clients)
  (global-set-key (kbd "M-RET") #'lsp-execute-code-action)
  (lsp)
  (my/enable-lsp-ui)
  (my/configure-lsp-company))

(defalias 'lsp--cur-line-diagnotics 'lsp--cur-line-diagnostics)

(provide 'conf-company)
