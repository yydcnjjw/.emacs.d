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
(global-company-mode 1)

(defun my/local-push-company-backend (backend)
  (make-local-variable 'company-backends)
  (push backend company-backends))

(require-package 'company-quickhelp)
(company-quickhelp-mode)

(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'flycheck)

(defun my/enable-lsp-ui()
  (with-eval-after-load 'lsp-ui-mode
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)))

(require-package 'company-lsp)

(defun my/lsp-configuration()
  ;; disable flymake at lsp-mode
  (setq lsp-prefer-flymake nil
        lsp-file-watch-threshold 2000)
  (global-set-key (kbd "M-RET") #'lsp-execute-code-action)
  (my/enable-lsp-ui)  )

(defun my/lsp-enable ()
  ;; `my/lsp-enable'.
  (interactive)
  (my/lsp-configuration)
  (lsp))

(defalias 'lsp--cur-line-diagnotics 'lsp--cur-line-diagnostics)

(provide 'conf-company)
