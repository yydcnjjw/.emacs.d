(require 'bison)
(add-to-list 'auto-mode-alist '("\\.y$" . bison-mode))
(autoload 'bison-mode "bison")

(require 'flex)
(add-to-list 'auto-mode-alist '("\\.l$" . flex-mode))
(autoload 'flex-mode "flex")

(add-hook 'bison-mode-hook
          #'(lambda ()
              (my/local-push-company-backend 'company-dabbrev-code)))

(add-hook 'flex-mode-hook
          #'(lambda ()
              (my/local-push-company-backend 'company-dabbrev-code)))

(provide 'conf-flex-bison)
