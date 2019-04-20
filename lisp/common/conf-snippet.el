(require-package 'yasnippet)
(require-package 'yasnippet-snippets)

(yas-global-mode 1)

(defun my/yasnippet-mode-enable ()
  (local-set-key (kbd "C-c y") #'company-yasnippet))
(my/add-hook-prog-and-text-mode #'my/yasnippet-mode-enable)

(provide 'conf-snippet)
