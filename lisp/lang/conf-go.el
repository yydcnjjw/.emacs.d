(require-package 'go-mode)
(push "GOPATH" exec-path-from-shell-variables)
(push "GOROOT" exec-path-from-shell-variables)

(add-hook 'go-mode-hook #'my/lsp-enable)

(provide 'conf-go)
