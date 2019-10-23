(require-package 'projectile)
(require-package 'ibuffer-projectile)

(when (executable-find "ag")
  (require-package 'ag))
(require-package 'skeletor)

(setq projectile-indexing-method 'hybrid
      projectile-ignored-project-function #'my/projectile-ignored-project-function)

(defcustom find-project-ignore-dir
  '("/usr")
  ""
  :type 'list)

(defun my/projectile-ignored-project-function(project-root)
  (member t (mapcar
             #'(lambda (dir)
                 (string-prefix-p dir project-root)
                 )
             find-project-ignore-dir
             )))


(my/projectile-ignored-project-function "/usr/bin")

(defun my/projectile-dynamic-change-index-method()
  (when (projectile-project-p)
    (if (eq (projectile-project-vcs) 'none)
        (setq projectile-indexing-method 'native)
      (setq projectile-indexing-method 'hybrid))))

(defun my/projectile-custom-switch-action()
  (my/projectile-dynamic-change-index-method)
  (projectile-find-file))
(setq projectile-switch-project-action #'my/projectile-custom-switch-action)

(add-hook 'find-file-hook #'my/projectile-dynamic-change-index-method)
(add-hook 'dired-mode-hook #'my/projectile-dynamic-change-index-method)

(setq skeletor-user-directory "~/.emacs.d/lisp/lib/template")

(defun my/projectile-project-root ()
  "no project return default-directory"
  (setq projectile-require-project-root nil)
  (setq project-root-dir (projectile-project-root))
  (setq projectile-require-project-root t)
  project-root-dir)

(defun reload-dir-locals-for-project ()
  "For every buffer with the same `projectile-project-root' as the 
current buffer's, reload dir-locals."
  (interactive)
  (dolist (buffer (projectile-project-buffer-names))
    (with-current-buffer buffer
      (reload-dir-locals-for-curent-buffer))))

;; `projectile'
(setq projectile-completion-system 'ivy
      projectile-enable-caching t)

;; `ibuffer-projectile'
(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))
(projectile-global-mode)
(define-key projectile-mode-map (kbd "C-c p")
                'projectile-command-map)

(provide 'conf-projectile)
