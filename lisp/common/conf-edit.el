(prefer-coding-system 'utf-8)

(setq enable-local-variables :all
      enable-local-eval t)

(when (executable-find "zsh")
  (setq shell-file-name "/bin/zsh"))
(setq indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; `flycheck'
(setq flycheck-check-syntax-automatically '(save mode-enabled))

(require-package 'hungry-delete)
(dolist (hook '(emacs-lisp-mode-hook
                c-mode-hook
                c++-mode-hook
		sh-mode-hook
                web-mode-hook
                html-mode-hook
                css-mode-hook
                js-mode-hook
                cmake-mode-hook
                scheme-mode-hook
		web-mode-hook
		typescript-mode-hook
		js2-mode-hook))
  (add-hook hook #'hungry-delete-mode))

;; Modify the default function `set-mark-command' key
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "s-SPC") #'set-mark-command)

(require-package 'comment-tags)
(with-eval-after-load 'comment-tags
  (setq comment-tags-keymap-prefix (kbd "C-c t"))
  (setq comment-tags-keyword-faces
        `(("TODO" . ,(list :weight 'bold :foreground "#28ABE3"))
          ("FIXME" . ,(list :weight 'bold :foreground "#DB3340"))
          ("BUG" . ,(list :weight 'bold :foreground "#DB3340"))
	  ("NOTE" . ,(list :weight 'bold :foreground "#FFF68E"))
          ("HACK" . ,(list :weight 'bold :foreground "#E8B71A"))
          ("XXX" . ,(list :weight 'bold :foreground "#F7EAC8"))
          ("INFO" . ,(list :weight 'bold :foreground "#F7EAC8"))
          ("DONE" . ,(list :weight 'bold :foreground "#1FDA9A"))))
  (setq comment-tags-comment-start-only t
        comment-tags-require-colon t
        comment-tags-case-sensitive t
        comment-tags-show-faces t
        comment-tags-lighter nil))
(add-hook 'prog-mode-hook #'comment-tags-mode)

;; electric
(setq show-paren-delay 0)
(add-hook 'after-init-hook #'show-paren-mode)

;; pair
(require-package 'paredit-everywhere)
(add-hook 'prog-mode-hook #'paredit-everywhere-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)

;; auto save
(setq auto-save-visited-interval 1)
(my/add-hook-prog-and-text-mode #'auto-save-visited-mode)

(require-package 'avy)
(global-set-key (kbd "C-:") #'avy-goto-char)
(global-set-key (kbd "C-'") #'avy-goto-char-2)

;; conf `pyim'
(require-package 'pyim)
(require-package 'posframe)
(with-eval-after-load 'pyim
  (pyim-basedict-enable)
  (setq default-input-method "pyim"
        pyim-default-scheme 'quanpin
        pyim-page-tooltip 'posframe
        pyim-page-length 5)
  (global-set-key (kbd "M-f") #'pyim-forward-word)
  (global-set-key (kbd "M-b") #'pyim-backward-word))
(require 'pyim)

;; conf `atomic-chrome'
(require-package 'atomic-chrome)
(with-eval-after-load 'atomic-chrome
  (setq atomic-chrome-default-major-mode 'markdown-mode
        atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ("redmine" . textile-mode))))
(add-hook 'after-init-hook #'atomic-chrome-start-server)

;; conf exec-path from shell
(require-package 'exec-path-from-shell)
(require 'exec-path-from-shell)
(add-hook 'after-init-hook
	  #'(lambda ()
	      (when (memq window-system '(mac ns x))
		(exec-path-from-shell-initialize))))

;; `eldoc'
(setq eldoc-print-after-edit nil)

(setq fill-column 80
      select-enable-clipboard t
      initial-scratch-message ""
      cursor-in-non-selected-windows t
      tab-width 4)

(provide 'conf-edit)
