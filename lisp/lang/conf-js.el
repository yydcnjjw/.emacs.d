;; depend npm tern

;; (defun my/js-company ()
;;   (add-to-list 'company-backends '(company-tern company-yasnippet))
;;   (tern-mode 1))

;; (add-hook 'js-mode-hook 'my/js-company)

;; (add-hook 'json-mode-hook
;;           (lambda ()
;;             (my/disable-minor-modes '(company-mode
;;                                       lsp-mode
;;                                       yas-minor-mode
;;                                       flyspell-mode
;;                                       semantic-mode))))

(provide 'conf-js)
