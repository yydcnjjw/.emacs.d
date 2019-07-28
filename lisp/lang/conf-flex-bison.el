(require 'bison)
(add-to-list 'auto-mode-alist '("\\.y$" . bison-mode))
(autoload 'bison-mode "bison")

(require 'flex)
(add-to-list 'auto-mode-alist '("\\.l$" . flex-mode))
(autoload 'flex-mode "flex")

(provide 'conf-flex-bison)
