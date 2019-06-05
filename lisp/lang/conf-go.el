(require-package 'go-mode)
(push "GOPATH" exec-path-from-shell-variables)
(push "GOROOT" exec-path-from-shell-variables)

(add-hook 'go-mode-hook #'my/lsp-enable)
;; (defun my/projectile-go-project-p ()
;;   "Check if a project contains Go source files."
;;   (projectile-verify-file "go.mod"))

;; (setq projectile-go-project-test-function
;;       #'my/projectile-go-project-p)

(provide 'conf-go)
