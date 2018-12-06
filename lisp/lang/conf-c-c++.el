(setq c-default-style '((c-mode . "linux")
			(c++-mode . "linux"))
      c-basic-offset 2)

(defun my/lsp-complete-p ()
  (let ((project-root-dir (projectile-project-p)))
    (if (or (file-exists-p (expand-file-name "compile_commands.json" project-root-dir))
            (file-exists-p (expand-file-name ".ccls" project-root-dir)))
        t
      nil)))

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
      (defun my/lsp-ui-peek-enable()
        (when enable-lsp-ui          
          (defun my/c-c++-callee ()
            (interactive)
            (lsp-ui-peek-find-custom 'callee "$ccls/call" '(:callee t)))
          (defun my/c-c++-caller ()
            (interactive)
            (lsp-ui-peek-find-custom 'caller "$ccls/call"))
          (defun my/c-c++-vars (kind)
            (lsp-ui-peek-find-custom 'vars "$ccls/vars" `(:kind ,kind)))
          (defun my/c-c++-base (levels)
            (lsp-ui-peek-find-custom 'base "$ccls/inheritance" `(:levels ,levels)))
          (defun my/c-c++derived (levels)
            (lsp-ui-peek-find-custom 'derived "$ccls/inheritance" `(:levels ,levels :derived t)))
          (defun my/c-c++member (kind)
            (interactive)
            (lsp-ui-peek-find-custom 'member "$ccls/member" `(:kind ,kind)))))

      (defun my/lsp-ccls-enable ()
        (setq ccls-extra-args '("--log-file=/tmp/ccls.log"))
        (setq
         ccls-initialization-options
         '(:completion
           (:include
            (:blacklist ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
                         "^/usr/(local/)?include/c\\+\\+/v1/"]))))
        (setq company-transformers nil
              company-lsp-async t
              company-lsp-cache-candidates nil)
        (my/lsp-ui-peek-enable)
        (require 'ccls)
        (lsp))

      ;; configure-c-c++-company
      (dolist (hook '(c-mode-hook
                      c++-mode-hook))
        (add-hook
         hook (lambda ()
                (when (my/lsp-complete-p)
                  (setq tags-file-name system-tags-url)
                  (my/configure-lsp-company)
                  (my/lsp-ccls-enable)))))

      (defun my/add-ccls-custom-index-file ()
        (if (projectile-project-p)
            (let ((index-file (expand-file-name my/c-c++-project-index-file default-directory)))
              (unless (file-exists-p index-file)
                (shell-command (format "cp ~/.emacs.d/lisp/lib/template/ccls-once-file-template %s" index-file))))
          (message "not project")))
      )
  (message "option: require ccls executable set `ccls-executable'"))

(require-package 'cmake-mode)
(defun my/cmake-company ()
  (my/local-push-company-backend '(company-cmake company-yasinppet)))
(add-hook 'cmake-mode-hook #'my/cmake-company)

(require-package 'xcscope)
(require-package 'ggtags)
(require-package 'clang-format)

(require-package 'company-c-headers)
(setq company-c-headers-path-system '("/usr/include"))

(dolist (hook '(c-mode-hook
                c++-mode-hook
                asm-mode-hook))
  (add-hook
   hook (lambda ()
          (unless (my/lsp-complete-p)
            (require 'xcscope)
            (cscope-minor-mode 1)
            (ggtags-mode)
            (flycheck-mode)
            (my/local-push-company-backend '(company-gtags company-dabbrev-code))
            (my/local-push-company-backend 'company-c-headers)
            ))))

(setq gtags-lib-path '("/usr/include"))
(setenv "MAKEOBJDIRPREFIX" (file-truename "/home/yydcnjjw/resources/basic/tags"))
(dolist (dir gtags-lib-path)
  (my/append-env-value "GTAGSLIBPATH"
                       dir))
(provide 'conf-c-c++)
