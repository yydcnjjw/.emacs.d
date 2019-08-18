(setq-default c-basic-offset 4)

(setq tags-table-list (list (expand-file-name "~/resources/basic/tags/SYSTAGS")))

(require-package 'ccls)
;; c/c++/Object-c
(setq my/c-c++-project-index-file ".ccls")
(with-eval-after-load 'projectile
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json"
                  ".ccls")
                projectile-project-root-files-top-down-recurring)))

(defun my/lsp-ccls-enable ()
  (setq ccls-args '("--log-file=/tmp/ccls.log"))
  (setq ccls-initialization-options
        '(:index (:comments 2)
                 :completion (:detailedLabel t)
                 :cache (:format "json")
                 ))
  (require 'ccls)
  (my/lsp-enable))

(defun my/add-ccls-custom-index-file ()
  (if (projectile-project-p)
      (let ((index-file (expand-file-name my/c-c++-project-index-file default-directory)))
        (unless (file-exists-p index-file)
          (shell-command (format "cp ~/.emacs.d/lisp/lib/template/ccls-once-file-template %s" index-file))))
    (message "not project")))

(require-package 'clang-format)

(when (executable-find "gtags")
  (require-package 'xcscope)
  (require-package 'ggtags)
  (require-package 'company-c-headers)
  (defun tag-find-enable (&optional use-system)
    (interactive)
    (unless (or (my/lsp-complete-p) (minor-mode-p 'lsp-mode))
      (let ((MAKEOBJDIRPREFIX "MAKEOBJDIRPREFIX")
            (GTAGSLIBPATH "GTAGSLIBPATH"))
        (if use-system
            (progn
              (setq gtags-lib-path '("/usr/include/"))
              (setenv MAKEOBJDIRPREFIX (file-truename "/home/yydcnjjw/resources/basic/tags"))
              (dolist (dir gtags-lib-path)
                (my/append-env-value "GTAGSLIBPATH"
                                     dir)))
          (progn
            (setenv MAKEOBJDIRPREFIX "")
            (setenv GTAGSLIBPATH ""))))
      
      (require 'xcscope)
      (cscope-minor-mode 1)
      (ggtags-mode)))

  (defun tag-complete-enable (&optional use-system)
    (interactive)
    (unless (or (my/lsp-complete-p) (minor-mode-p 'lsp-mode))
      (tag-find-enable use-system)
      (my/local-push-company-backend '(company-gtags company-dabbrev-code))
      (my/local-push-company-backend 'company-c-headers)))
  
  (defun tag-complete-enable-no-system ()
    (interactive)
    (tag-complete-enable nil))
  (defun tag-find-enable-no-system ()
    (interactive)
    (tag-find-enable nil)))

(defun my/lsp-complete-p ()
  (let ((project-root-dir (projectile-project-p)))
    (if (or (file-exists-p (expand-file-name "compile_commands.json" project-root-dir))
            (file-exists-p (expand-file-name ".ccls" project-root-dir)))
        t
      nil)))

;; configure-c-c++-company
(dolist (hook '(c-mode-hook
                c++-mode-hook))
  (add-hook
   hook #'(lambda ()
            (if (my/lsp-complete-p)
                (my/lsp-ccls-enable)
              (progn
                (cscope-setup)
                (tag-complete-enable-no-system)
                (add-hook 'dired-mode-hook (function cscope-minor-mode)))))))


(defun c-c++-org-src-complete ()
  (when (or (eq major-mode 'c++-mode) (eq major-mode 'c-mode))
    (tag-complete-enable)))
(add-hook 'org-src-mode-hook #'c-c++-org-src-complete)

(when (executable-find "cmake")
  (require-package 'cmake-mode)
  (defun my/cmake-company ()
    (my/local-push-company-backend '(company-cmake company-yasnippet)))
  (add-hook 'cmake-mode-hook #'my/cmake-company))
(provide 'conf-c-c++)
