(defconst my/en-font "hack-12")
(defconst my/zh-font "Noto Sans CJK SC")

(set-frame-font my/en-font)

(defun my/set-font (charsets font)
  (dolist (charset charsets)
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec
      :family font))))

;; (setq face-font-rescale-alist
;;      '(("Noto.*" . 1.2)))
(when window-system
  (my/set-font '(kana han cjk-misc bopomofo symbol) my/zh-font)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(menu-bar-mode -1)

(setq inhibit-splash-screen 1
      ring-bell-function 'ignore)

(when window-system
  (setq-default cursor-type 'bar)
  (setq frame-resize-pixelwise t))

(require-package 'spacemacs-theme)
(load-theme 'spacemacs-dark t)

;; `display-line-numbers'
(setq display-line-numbers-width-start t)
(set-face-attribute 'line-number nil
                    :background nil)
(my/add-hook-prog-and-text-mode #'display-line-numbers-mode)
(column-number-mode +1)
(global-hl-line-mode +1)
(add-hook 'prog-mode-hook #'goto-address-prog-mode)
(add-hook 'text-mode-hook #'goto-address-mode)

;; `highlight-numbers'
(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(add-hook 'shell-mode-hook #'ansi-color-for-comint-mode-on)

;; Cancel automatic generation of backup files
(setq make-backup-files nil)

(provide 'conf-ui)
