(setq c-default-style "linux"
      c-basic-offset 4)

(if (executable-find ccls-executable)
    (progn
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
        (setq
         ccls-initialization-options
         '(:completion
           (:include
            (:blacklist ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
                         "^/usr/(local/)?include/c\\+\\+/v1/"]))))
        (setq company-transformers nil
              company-lsp-async t
              company-lsp-cache-candidates nil)
        (require 'ccls)
        (my/lsp-enable))
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
         hook (lambda ()
                (when (my/lsp-complete-p)
                  (my/lsp-ccls-enable)
                  ))))

      (defun my/add-ccls-custom-index-file ()
        (if (projectile-project-p)
            (let ((index-file (expand-file-name my/c-c++-project-index-file default-directory)))
              (unless (file-exists-p index-file)
                (shell-command (format "cp ~/.emacs.d/lisp/lib/template/ccls-once-file-template %s" index-file))))
          (message "not project")))
      )
  (message "option: require ccls executable set `ccls-executable'"))

(require-package 'clang-format)
(setq clang-format-style "{BasedOnStyle: LLVM, IndentWidth: 4}")

(when (executable-find "gtags")
  (require-package 'xcscope)
  (require-package 'ggtags)
  (require-package 'company-c-headers)
  (setq company-c-headers-path-system '("/usr/include"))
  (defun tag-find-enable ()
    (interactive)
    (unless (or (my/lsp-complete-p) (minor-mode-p 'lsp-mode))
      (require 'xcscope)
      (cscope-minor-mode 1)
      (ggtags-mode)))
  (defun tag-complete-enable ()
    (interactive)
    (unless (or (my/lsp-complete-p) (minor-mode-p 'lsp-mode))
      (require 'xcscope)
      (cscope-minor-mode 1)
      (ggtags-mode)
      (flycheck-mode 1)
      (my/local-push-company-backend '(company-gtags company-dabbrev-code))
      (my/local-push-company-backend 'company-c-headers)))
  (setq gtags-lib-path '("/usr/include/"))
  (setenv "MAKEOBJDIRPREFIX" (file-truename "/home/yydcnjjw/resources/basic/tags"))
  (dolist (dir gtags-lib-path)
    (my/append-env-value "GTAGSLIBPATH"
                         dir)))

(defun c-c++-org-src-complete ()
  (when (or (eq major-mode 'c++-mode) (eq major-mode 'c-mode))
    (tag-complete-enable)))
(add-hook 'org-src-mode-hook #'c-c++-org-src-complete)

(when (executable-find "cmake")
  (require-package 'cmake-mode)
  (defun my/cmake-company ()
    (my/local-push-company-backend '(company-cmake company-yasinppet)))
  (add-hook 'cmake-mode-hook #'my/cmake-company))
(provide 'conf-c-c++)
