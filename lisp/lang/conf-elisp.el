(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (flycheck-mode 1)
              (my/local-push-company-backend
               '(company-elisp company-yasnippet company-files))))
(provide 'conf-elisp)
