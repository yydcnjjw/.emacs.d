(defun my/lsp-shell-enable ()
  ;; (setq-local company-lsp-cache-candidates t)
  (my/lsp-enable))
(add-hook 'sh-mode-hook 'my/lsp-shell-enable)
(require 'aweshell)

(provide 'conf-shell)
