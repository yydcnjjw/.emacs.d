(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (flycheck-mode 1)
              (paredit-mode)
              (my/local-push-company-backend
               '(company-elisp company-yasnippet company-files))))
(provide 'conf-elisp)
