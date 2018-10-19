(setq shell-file-name "/bin/bash")
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq-default indent-tabs-mode nil)

(require-package 'hungry-delete)
(dolist (hook '(emacs-lisp-mode-hook
                c-mode-hook
                c++-mode-hook
                cmake-mode-hook))
  (add-hook hook #'hungry-delete-mode))

;; Modify the default function `set-mark-command' key
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "s-SPC") 'set-mark-command)

(require-package 'comment-tags)
(with-eval-after-load 'comment-tags
  (setq comment-tags-keymap-prefix (kbd "C-c t"))
  (setq comment-tags-keyword-faces
        `(("TODO" . ,(list :weight 'bold :foreground "#28ABE3"))
          ("FIXME" . ,(list :weight 'bold :foreground "#DB3340"))
          ("BUG" . ,(list :weight 'bold :foreground "#DB3340"))
          ("HACK" . ,(list :weight 'bold :foreground "#E8B71A"))
          ("KLUDGE" . ,(list :weight 'bold :foreground "#E8B71A"))
          ("XXX" . ,(list :weight 'bold :foreground "#F7EAC8"))
          ("INFO" . ,(list :weight 'bold :foreground "#F7EAC8"))
          ("DONE" . ,(list :weight 'bold :foreground "#1FDA9A"))))
  (setq comment-tags-comment-start-only t
        comment-tags-require-colon t
        comment-tags-case-sensitive t
        comment-tags-show-faces t
        comment-tags-lighter nil))
(add-hook 'prog-mode-hook 'comment-tags-mode)

;; electric
(setq show-paren-delay 0)
(add-hook 'after-init-hook 'show-paren-mode)
(defun my/conf-electric-pair-mode()
  (electric-pair-mode)
  (setq electric-pair-pairs '(
                              (?\" . ?\")
                              (?\' . ?\')
                              (?\( . ?\))
                              (?\{ . ?\})
                              )))
(add-hook 'prog-mode-hook 'my/conf-electric-pair-mode)

;; auto save
(setq auto-save-visited-interval 1)
(my/add-hook-prog-and-text-mode 'auto-save-visited-mode)

(require-package 'avy)
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)

;; conf `pyim'
(require-package 'pyim)
(require-package 'posframe)
(with-eval-after-load 'pyim
  (pyim-basedict-enable)
  (setq default-input-method "pyim")
  (setq pyim-default-scheme 'quanpin)
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-length 5)
  (global-set-key (kbd "M-f") 'pyim-forward-word)
  (global-set-key (kbd "M-b") 'pyim-backward-word))
(require 'pyim)

;; conf `atomic-chrome'
(require-package 'atomic-chrome)
(with-eval-after-load 'atomic-chrome
  (setq atomic-chrome-default-major-mode 'markdown-mode)
  (setq atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ("redmine" . textile-mode))))
(add-hook 'after-init-hook 'atomic-chrome-start-server)

;; conf `origami'
(require-package 'origami)
(with-eval-after-load 'origami
  (define-key origami-mode-map (kbd "<C-s-return>") 'origami-recursively-toggle-node)
  (define-key origami-mode-map (kbd "<C-S-return>") 'origami-show-only-node))
(add-hook 'prog-mode-hook 'origami-mode)

(provide 'conf-edit)
