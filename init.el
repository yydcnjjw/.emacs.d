(setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(require 'load-conf)
(setenv "MAGICK_OCL_DEVICE" "OFF")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets xcscope virtualenvwrapper spacemacs-theme skeletor pyim posframe org2ctex org-ref org-plus-contrib org-download markdown-preview-mode magit lsp-ui ivy-xref hungry-delete graphviz-dot-mode google-translate flyspell-correct-ivy ein dockerfile-mode docker counsel company-shell company-quickhelp company-math company-lsp company-glsl comment-tags cmake-mode chinese-word-at-point cdlatex ccls avy auto-package-update auctex atomic-chrome ag)))
 '(safe-local-variable-values
   (quote
    ((build-option . "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_ENABLE_RTTI=on")
     (eval my/view-mode-fun)
     (build-dir . "debug")
     (build-option . "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
     (build-type . "Debug")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))
