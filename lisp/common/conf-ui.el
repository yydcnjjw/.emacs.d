(defconst my/en-font "hack 12")
(defconst my/zh-font "Noto Sans CJK SC")
(set-frame-font my/en-font)
(when window-system
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec
      :family my/zh-font))))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen 1
      ring-bell-function 'ignore)

(when window-system
  (setq-default cursor-type 'bar)
  (column-number-mode 1)
  (setq
   frame-resize-pixelwise t))

(require-package 'spacemacs-theme)
(load-theme 'spacemacs-dark t)

;; `display-line-numbers'
(setq display-line-numbers-width-start t)
(set-face-attribute 'line-number nil
                    :background nil)

(my/add-hook-prog-and-text-mode 'display-line-numbers-mode)
(global-hl-line-mode 1)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Cancel automatic generation of backup files
(setq make-backup-files nil)

(provide 'conf-ui)
