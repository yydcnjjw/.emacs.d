(defconst my/en-font "hack 12")
(set-frame-font my/en-font)
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Noto Sans CJK SC")))

(custom-set-faces
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))

(setq-default cursor-type 'bar)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-resize-pixelwise t)
(setq inhibit-splash-screen 1)
(global-hl-line-mode t)
(require-package 'spacemacs-theme)
(load-theme 'spacemacs-dark t)
(global-linum-mode t)

(setq ring-bell-function 'ignore)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Cancel automatic generation of backup files
(setq make-backup-files nil)

(provide 'conf-ui)
