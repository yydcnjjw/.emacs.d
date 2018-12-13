(defun load-elisp-conf ()
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (my/local-push-company-backend
               '(company-elisp company-yasnippet))
              (paredit-mode 1))))
(add-hook 'after-init-hook 'load-elisp-conf)

(provide 'conf-elisp)
