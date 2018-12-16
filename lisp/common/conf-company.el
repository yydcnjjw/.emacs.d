(require-package 'company)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-backends '(company-files
	                   company-keywords
                           ;; company-capf
	                   company-abbrev
	                   company-dabbrev)))
(my/add-hook-prog-and-text-mode 'company-mode)

(defun my/local-push-company-backend (backend)
  (make-local-variable 'company-backends)
  (push backend company-backends))

(require-package 'company-quickhelp)
(with-eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'flycheck)

;; disable flymake at lsp-mode
(setq lsp-prefer-flymake nil)

(defcustom enable-lsp-ui t
  ""
  :type 'boolean)

(defun my/enable-lsp-ui()
  (when enable-lsp-ui
    (lsp-ui-mode 1)
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)))

(add-hook 'lsp-mode-hook
          (lambda ()
            (my/enable-lsp-ui)
            (flycheck-mode 1)))

(require-package 'company-lsp)
(defun my/configure-lsp-company ()
  (require 'company-lsp)
  (setq company-lsp-enable-snippet t)
  (setq company-lsp-enable-recompletion t)
  (global-set-key (kbd "M-RET") 'lsp-execute-code-action)
  (my/local-push-company-backend 'company-lsp))

(provide 'conf-company)
