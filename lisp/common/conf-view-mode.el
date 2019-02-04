(defun my/view-mode-fun ()
  (when buffer-file-name
    (unless (file-writable-p buffer-file-name)
      (my/disable-minor-modes '(company-mode
                                flycheck-mode
                                yas-minor-mode
                                hungry-delete-mode
                                flyspell-mode
                                semantic-mode)))
    (view-mode-enter nil #'kill-buffer)))
(dir-locals-set-class-variables 'my/view-mode
                                '((nil . ((eval . (my/view-mode-fun))))))

(defcustom view-mode-file-dirs
  ""
  '())

(setq my/view-mode-file-dirs
      '("~/.emacs.d/elpa"
        "~/.emacs.d/site-packages/web-lsp"
        "/usr/include"
        "/usr/local/include"
        "~/.local/lib"
        "/usr/lib"
        "/usr/local/src/emacs"
        "/usr/local/share/emacs"
        "/usr/share/emacs"
        "/usr/share/racket"))

(dolist (dir view-mode-file-dirs)
  (add-to-list 'my/view-mode-file-dirs dir))

(defun my/load-dir-view-mode ()
  (dolist (dir my/view-mode-file-dirs)
    (dir-locals-set-directory-class dir 'my/view-mode)))

(defun my/add-dir-to-view-mode (dir)
  (add-to-list 'my/view-mode-file-dirs dir)
  (my/load-dir-view-mode))
(add-hook 'after-init-hook #'my/load-dir-view-mode)

(provide 'conf-view-mode)
