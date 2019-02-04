(require-package 'haskell-mode)
(when (executable-find "stack")
  (require-package 'intero)
  (add-hook 'haskell-mode-hook
            #'(lambda ()
		(intero-mode 1)
		)))

(provide 'conf-haskell)
