(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (my/local-push-company-backend '(company-elisp company-yasnippet))
            (company-quickhelp-local-mode t)))
(provide 'conf-elisp)
