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
    (nasm-mode counsel w3m lsp-python-ms helm org-ref elfeed-org elfeed-goodies elfeed expand-region slime restclient elpy lv yasnippet-snippets xcscope web-mode vue-mode virtualenvwrapper uuidgen tide spacemacs-theme skeletor rjsx-mode pyim protobuf-mode posframe org-download ob-ipython markdown-preview-mode magit lsp-ui ivy-xref ivy-hydra intero ibuffer-projectile hungry-delete groovy-mode graphviz-dot-mode google-translate go-mode ghub ggtags geiser flyspell-correct-ivy flycheck-pos-tip flycheck-plantuml exec-path-from-shell emmet-mode dockerfile-mode docker dart-mode csv-mode company-web company-quickhelp company-math company-lsp company-glsl company-c-headers comment-tags cmake-mode clang-format chinese-word-at-point cdlatex ccls avy auto-package-update auctex atomic-chrome ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
