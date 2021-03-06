(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq enable-local-variables :all
      enable-local-eval t)

(when (executable-find "zsh")
  (setq shell-file-name "/bin/zsh"))
(setq-default indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; `flycheck'
(setq flycheck-check-syntax-automatically '(save mode-enabled))

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
(show-paren-mode 1)
(add-hook 'prog-mode-hook #'electric-pair-mode)

;; pair
(when (display-graphic-p)
  (require 'awesome-pair)
  (dolist (hook (list
                 'haskell-mode-hook
                 'emacs-lisp-mode-hook
                 'lisp-interaction-mode-hook
                 'lisp-mode-hook
                 'maxima-mode-hook
                 'ielm-mode-hook
                 'sh-mode-hook
                 'makefile-gmake-mode-hook
                 'php-mode-hook
                 'python-mode-hook
                 'js-mode-hook
                 'go-mode-hook
                 'qml-mode-hook
                 'jade-mode-hook
                 'css-mode-hook
                 'ruby-mode-hook
                 'coffee-mode-hook
                 'rust-mode-hook
                 'qmake-mode-hook
                 'lua-mode-hook
                 'swift-mode-hook
                 'minibuffer-inactive-mode-hook))
    (add-hook hook '(lambda () (awesome-pair-mode 1))))

  (define-key awesome-pair-mode-map (kbd "(") 'awesome-pair-open-round)
  (define-key awesome-pair-mode-map (kbd "[") 'awesome-pair-open-bracket)
  (define-key awesome-pair-mode-map (kbd "{") 'awesome-pair-open-curly)
  (define-key awesome-pair-mode-map (kbd ")") 'awesome-pair-close-round)
  (define-key awesome-pair-mode-map (kbd "]") 'awesome-pair-close-bracket)
  (define-key awesome-pair-mode-map (kbd "}") 'awesome-pair-close-curly)
  (define-key awesome-pair-mode-map (kbd "=") 'awesome-pair-equal)

  (define-key awesome-pair-mode-map (kbd "%") 'awesome-pair-match-paren)
  (define-key awesome-pair-mode-map (kbd "\"") 'awesome-pair-double-quote)
  (define-key awesome-pair-mode-map (kbd "SPC") 'awesome-pair-space)

  ;; (define-key awesome-pair-mode-map (kbd "M-o") 'awesome-pair-backward-delete)
  (define-key awesome-pair-mode-map (kbd "C-d") 'awesome-pair-forward-delete)
  (define-key awesome-pair-mode-map (kbd "C-k") 'awesome-pair-kill)

  (define-key awesome-pair-mode-map (kbd "M-\"") 'awesome-pair-wrap-double-quote)
  (define-key awesome-pair-mode-map (kbd "M-[") 'awesome-pair-wrap-bracket)
  (define-key awesome-pair-mode-map (kbd "M-{") 'awesome-pair-wrap-curly)
  (define-key awesome-pair-mode-map (kbd "M-(") 'awesome-pair-wrap-round)
  (define-key awesome-pair-mode-map (kbd "M-)") 'awesome-pair-unwrap)

  (define-key awesome-pair-mode-map (kbd "M-p") 'awesome-pair-jump-right)
  (define-key awesome-pair-mode-map (kbd "M-n") 'awesome-pair-jump-left)
  (define-key awesome-pair-mode-map (kbd "M-:") 'awesome-pair-jump-out-pair-and-newline))


;; auto save
(setq auto-save-visited-interval 1)
(my/add-hook-prog-and-text-mode #'auto-save-visited-mode)

;; `avy'
(require-package 'avy)
(global-set-key (kbd "C-:") #'avy-goto-char)
(global-set-key (kbd "C-'") #'avy-goto-char-2)

;; conf `pyim'
(require-package 'pyim)
(require-package 'posframe)
(require 'pyim)
(require 'pyim-basedict)
(pyim-basedict-enable)
(setq default-input-method "pyim"
      pyim-default-scheme 'quanpin
      pyim-page-tooltip 'posframe
      pyim-page-length 5)
(global-set-key (kbd "M-f") #'pyim-forward-word)
(global-set-key (kbd "M-b") #'pyim-backward-word)

;; conf `atomic-chrome'
(require-package 'atomic-chrome)
(with-eval-after-load 'atomic-chrome
  (setq atomic-chrome-default-major-mode 'markdown-mode
        atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ("redmine" . textile-mode))))
;; (add-hook 'after-init-hook #'atomic-chrome-start-server)

;; conf exec-path from shell
(require-package 'exec-path-from-shell)
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
                (exec-path-from-shell-initialize))

;; `eldoc'
(setq eldoc-print-after-edit nil)

;; `expand-region'
(require-package 'expand-region)
(require 'expand-region)
(global-set-key (kbd "C-M-w") 'er/expand-region)

;; paredit
(require-package 'paredit)
;; misc
(setq select-enable-clipboard t
      initial-scratch-message ""
      cursor-in-non-selected-windows t)

(setq-default tab-width 4
              fill-column 80)

(provide 'conf-edit)
