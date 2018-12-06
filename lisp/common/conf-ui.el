(defconst my/en-font "hack 12")
(set-frame-font my/en-font)

(when window-system
  (setq-default cursor-type 'bar)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (column-number-mode 1)
  (setq
   frame-resize-pixelwise t
   inhibit-splash-screen 1))

(require-package 'spacemacs-theme)

(add-hook 'after-init-hook
          (lambda ()
            (load-theme 'spacemacs-dark t)
            (add-hook 'prog-mode-hook 'linum-mode)
            (my/add-hook-prog-and-text-mode
             (lambda ()
               (hl-line-mode)))))

(setq ring-bell-function 'ignore)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Cancel automatic generation of backup files
(setq make-backup-files nil)

(provide 'conf-ui)
