(defun my/lsp-shell-enable ()
  (my/lsp-enable))
(add-hook 'sh-mode-hook #'my/lsp-shell-enable)
(require 'aweshell)

(provide 'conf-shell)
