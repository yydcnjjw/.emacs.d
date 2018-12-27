(defun my/shell-company ()
  (my/local-push-company-backend '(company-shell company-shell-env company-fish-shell)))
(require-package 'company-shell)
(add-hook 'sh-mode-hook 'my/shell-company)
(require 'aweshell)
  
(provide 'conf-shell)
