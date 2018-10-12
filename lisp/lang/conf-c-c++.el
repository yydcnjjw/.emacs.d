(if (executable-find ccls-executable)
    (progn
      (require-package 'ccls)
      (require-package 'xcscope)

      ;; c/c++/Object-c
      (setq my/c-c++-project-index-file ".ccls")
      (with-eval-after-load 'projectile
        (setq projectile-project-root-files-top-down-recurring
              (append '("compile_commands.json"
                        ".ccls")
                      projectile-project-root-files-top-down-recurring)))

      (defun my/lsp-ccls-enable ()
        (setq ccls-extra-args '("--log-file=/tmp/ccls.log"))
        (setq
         ccls-extra-init-params
         '(:completion
           (:include
            (:blacklist ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
                         "^/usr/(local/)?include/c\\+\\+/v1/"]))))
        (setq company-transformers nil
              company-lsp-async t
              company-lsp-cache-candidates nil)
        (lsp-ccls-enable)
        (lsp-enable-imenu))

      (defun ccls/callee ()
        (interactive)
        (lsp-ui-peek-find-custom 'callee "$ccls/call" '(:callee t)))
      (defun ccls/caller ()
        (interactive)
        (lsp-ui-peek-find-custom 'caller "$ccls/call"))
      (defun ccls/vars (kind)
        (lsp-ui-peek-find-custom 'vars "$ccls/vars" `(:kind ,kind)))
      (defun ccls/base (levels)
        (lsp-ui-peek-find-custom 'base "$ccls/inheritance" `(:levels ,levels)))
      (defun ccls/derived (levels)
        (lsp-ui-peek-find-custom 'derived "$ccls/inheritance" `(:levels ,levels :derived t)))
      (defun ccls/member (kind)
        (interactive)
        (lsp-ui-peek-find-custom 'member "$ccls/member" `(:kind ,kind)))

      (defun my/c-c++-mode-code-format ()
        (setq c-default-style '((c-mode . "linux")
			        (c++-mode . "linux"))
              c-basic-offset 2))

      ;; configure-c-c++-company
      (dolist (hook '(c-mode-hook
                      c++-mode-hook))
        (add-hook
         hook (lambda ()
                (my/c-c++-mode-code-format)
                (when (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
                  (when (and buffer-file-name (not buffer-read-only))
                    (let ((project-type (projectile-project-type)))
                      (if (equal project-type 'linux-kernel)
                          (progn
                            (require 'xcscope)
                            (cscope-minor-mode 1)
                            (my/local-push-company-backend
                             '(company-dabbrev-code company-gtags company-etags)))
                        (progn
                          (setq tags-file-name system-tags-url)
                          (when (equal project-type nil)
                            (let ((index-file (expand-file-name my/c-c++-project-index-file default-directory)))
                              (unless (file-exists-p index-file)
                                (shell-command (format "cp ~/.emacs.d/lisp/lib/template/cquery-once-file-template %s" index-file)))))
                          (my/configure-lsp-company)
                          (my/lsp-ccls-enable)
                          )))))))))
  (message "option: require ccls executable set `ccls-executable'"))

(require-package 'cmake-mode)
(defun my/cmake-company ()
  (my/local-push-company-backend '(company-cmake company-yasinppet)))
(add-hook 'cmake-mode-hook #'my/cmake-company)

(provide 'conf-c-c++)
