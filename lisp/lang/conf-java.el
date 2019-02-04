(defun my/lsp-java-enable ()
  (require 'lsp-intellij)
  (setq c-basic-offset 4)
  (setq company-lsp-enable-snippet t
        company-lsp-cache-candidates t)
  (my/configure-lsp-company)
  (lsp-intellij-enable))

(add-hook 'java-mode-hook #'my/lsp-java-enable)
(add-hook 'kotlin-mode-hook #'my/lsp-java-enable)

(provide 'conf-java)
