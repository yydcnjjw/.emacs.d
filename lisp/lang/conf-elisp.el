(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (my/local-push-company-backend '(company-elisp company-yasnippet))))
(provide 'conf-elisp)
