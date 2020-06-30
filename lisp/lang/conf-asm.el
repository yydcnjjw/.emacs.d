(require-package 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.nasm\\'" . nasm-mode))

(add-hook 'nasm-mode-hook
          #'(lambda ()
              (my/local-push-company-backend 'company-dabbrev-code)))

(add-hook 'asm-mode-hook
          #'(lambda ()
              (my/local-push-company-backend 'company-dabbrev-code)))

(provide 'conf-asm)
