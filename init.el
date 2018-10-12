(setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(require 'load-conf)
(setenv "MAGICK_OCL_DEVICE" "OFF")


;;  '(package-selected-packages
;;    (quote
;;     (use-package magit-todos ccls org-plus-contrib markdown-preview-mode ein flyspell-correct-ivy google-translate atomic-chrome posframe pyim lsp-vue vue-mode lsp-clangd kotlin-mode lsp-intellij lsp-html js2-mode json-mode chinese-word-at-point ag comment-tags org-ref virtualenvwrapper magit org2ctex graphviz-dot-mode web-mode company-restclient restclient clang-format htmlize cdlatex auctex avy-flycheck yasnippet-snippets xcscope spacemacs-theme skeletor projectile org-download lsp-ui lsp-python ivy-xref hungry-delete ggtags counsel company-shell company-quickhelp company-math company-lsp company-glsl cmake-mode)))
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
    ((eval my/view-mode-fun)
     (eval progn
           (defvar-local build-type "Debug")
           (defvar-local build-option "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
           (defvar-local build-dir "debug")
           (setq projectile-project-configure-cmd
                 (format "cmake -H. -B%s -DCMAKE_BUILD_TYPE=%s %s" build-dir build-type build-option))
           (setq projectile-project-compilation-cmd
                 (format "cmake --build %s" build-dir))
           (setq projectile-project-run-cmd
                 (format "%s" build-dir)))
     (eval progn
           (defvar-local build-type "Debug")
           (defvar-local build-option "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_ENABLE_RTTI=on")
           (defvar-local build-dir "debug")
           (setq projectile-project-configure-cmd
                 (format "cmake -H. -B%s -DCMAKE_BUILD_TYPE=%s %s" build-dir build-type build-option))
           (setq projectile-project-compilation-cmd
                 (format "cmake --build %s" build-dir))
           (setq projectile-project-run-cmd
                 (format "%s" build-dir)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))
