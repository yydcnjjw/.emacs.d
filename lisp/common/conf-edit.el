(setq shell-file-name "/bin/bash")
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq-default indent-tabs-mode nil)

(require-package 'hungry-delete)
(global-hungry-delete-mode)

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
(electric-layout-mode 1)
(setq show-paren-delay 0)
(show-paren-mode 1)
(defun my/conf-electric-pair-mode()
  (electric-pair-mode 1)
  (setq electric-pair-pairs '(
                              (?\" . ?\")
                              (?\' . ?\')
                              (?\( . ?\))
                              (?\{ . ?\})
                              )))
(add-hook 'prog-mode-hook 'my/conf-electric-pair-mode)

;; flyspell
(setq ispell-local-dictionary-alist
      '(("en_US-large"                      
         "[A-Za-z]"
         "[^A-Za-z]"
         "[']"
         nil
         ("-d" "en_US-large")
         nil utf-8)))
(setq ispell-dictionary "en_US-large")
(when (executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'text-mode-hook #'flyspell-mode)
(with-eval-after-load 'flyspell
  (require-package 'flyspell-correct-ivy)
  (require 'flyspell-correct-ivy)
  (define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-wrapper))

;; auto save
(setq auto-save-visited-interval 1)
(my/add-hook-prog-and-text-mode (lambda () (auto-save-visited-mode 1)))

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
(atomic-chrome-start-server)

(provide 'conf-edit)
