(require-package 'ivy)
(require-package 'ivy-hydra)
(require-package 'counsel)
(require-package 'ivy-xref)

(require 'ivy-hydra)
(ivy-mode 1)
(counsel-mode 1)
(global-set-key "\C-s" 'swiper)
(setq xref-show-xrefs-function #'ivy-xref-show-xrefs
      ivy-count-format "(%d/%d) "
      ivy-use-selectable-prompt t)

(provide 'conf-ivy)
