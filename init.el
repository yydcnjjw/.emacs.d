;; (setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(require 'load-conf)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (anki-editor lsp-python-ms company-lsp counsel ivy-hydra ivy-xref skeletor ag ibuffer-projectile csv-mode nasm-mode yaml-mode flycheck-plantuml plantuml-mode markdown-preview-mode graphviz-dot-mode company-glsl groovy-mode lua-mode org-ref helm ob-ipython auctex cdlatex company-math org-download slime-company slime geiser intero haskell-mode dart-mode protobuf-mode emmet-mode flycheck-pos-tip rjsx-mode tide typescript-mode vue-mode company-web web-mode go-mode lsp-java virtualenvwrapper ein polymode cmake-mode company-c-headers ggtags xcscope clang-format ccls w3m restclient wanderlust shimbun mew elfeed-goodies elfeed-org elfeed pdf-tools dockerfile-mode docker google-translate chinese-word-at-point flyspell-correct-ivy yasnippet-snippets yasnippet flycheck lsp-ui lsp-mode company-quickhelp company expand-region exec-path-from-shell atomic-chrome posframe pyim comment-tags treemacs-projectile treemacs-magit treemacs highlight-numbers spacemacs-theme ht))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
