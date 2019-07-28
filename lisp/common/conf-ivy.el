(require-package 'ivy)
(require-package 'ivy-xref)
(require-package 'ivy-hydra)
(require-package 'counsel)

(with-eval-after-load 'ivy
  (require 'ivy-hydra)
  (counsel-mode 1)
  (global-set-key "\C-s" 'swiper)
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs
        ivy-count-format "(%d/%d) "
        ivy-use-selectable-prompt t))

(add-hook 'after-init-hook #'ivy-mode)

(provide 'conf-ivy)
