(defun my/view-mode-fun ()
  (when buffer-file-name
    (when buffer-file-read-only
      (my/disable-minor-modes '(company-mode
                                lsp-mode
                                flycheck-mode
                                yas-minor-mode
                                hungry-delete-mode
                                flyspell-mode
                                semantic-mode)))
    (view-mode-enter nil #'kill-buffer)))
(dir-locals-set-class-variables 'my/view-mode
                                '((nil . ((eval . (my/view-mode-fun))))))

(setq view-mode-file-dir
      '("~/.emacs.d/elpa"
        "/usr/include"
        "/usr/local/include"
        "~/.local/lib"
        "/usr/lib"
        "/usr/local/src/emacs"
        "/usr/local/share/emacs"
        "/usr/share/emacs"))

(defun my/load-dir-view-mode ()
  (dolist (dir view-mode-file-dir)
    (dir-locals-set-directory-class dir 'my/view-mode)))

(defun my/add-dir-to-view-mode (dir)
  (add-to-list 'view-mode-file-dir dir)
  (my/load-dir-view-mode))
(add-hook 'after-init-hook 'my/load-dir-view-mode)

(provide 'conf-view-mode)
