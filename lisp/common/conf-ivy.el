(require-package 'ivy)
(require-package 'ivy-xref)
(require-package 'ivy-hydra)
(require-package 'counsel)

(with-eval-after-load 'ivy
  (require 'ivy-hydra)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        xref-show-xrefs-function #'ivy-xref-show-xrefs
        ivy-count-format "(%d/%d) "
        ivy-use-selectable-prompt t)
  (global-set-key (kbd "C-s") #'swiper)
  (global-set-key (kbd "C-c C-r") #'ivy-resume)
  (global-set-key (kbd "M-x") #'counsel-M-x)
  (global-set-key (kbd "C-x C-f") #'counsel-find-file)
  (global-set-key (kbd "<f1> f") #'counsel-describe-function)
  (global-set-key (kbd "<f1> v") #'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") #'counsel-find-library)
  (global-set-key (kbd "<f2> i") #'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") #'counsel-unicode-char)
  (global-set-key (kbd "C-c g") #'counsel-git)
  (global-set-key (kbd "C-c j") #'counsel-git-grep)
  (global-set-key (kbd "C-c k") #'counsel-ag)
  (global-set-key (kbd "C-x l") #'counsel-locate)
  (global-set-key (kbd "C-S-o") #'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") #'counsel-minibuffer-history))
(add-hook 'after-init-hook #'ivy-mode)

(provide 'conf-ivy)
