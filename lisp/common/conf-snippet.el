(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(defun my/yasnippet-mode-enable ()
  (yas-minor-mode)
  (yas-reload-all)
  (local-set-key (kbd "C-c y") 'company-yasnippet))
(my/add-hook-prog-and-text-mode 'my/yasnippet-mode-enable)

(provide 'conf-snippet)
