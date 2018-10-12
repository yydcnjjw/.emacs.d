(setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(setq support-languages '("c-c++"
                          "python"
                          "org"
                          "elisp"
                          "shell"
                          "glsl"
                          "dot"
                          "md"))

(setq support-projects '("cmake-project"
                         "python-project"
                         "js-project"
                         "gradle-project"
                         "idea"
                         "qt-project"
                         "linux-kernel"))

(setq ccls-executable "~/.emacs.d/site-packages/ccls/build/ccls")

(require 'load-conf)
(setenv "MAGICK_OCL_DEVICE" "OFF")

;;  '(package-selected-packages
;;    (quote
;;     (use-package magit-todos ccls org-plus-contrib markdown-preview-mode ein flyspell-correct-ivy google-translate atomic-chrome posframe pyim lsp-vue vue-mode lsp-clangd kotlin-mode lsp-intellij lsp-html js2-mode json-mode chinese-word-at-point ag comment-tags org-ref virtualenvwrapper magit org2ctex graphviz-dot-mode web-mode company-restclient restclient clang-format htmlize cdlatex auctex avy-flycheck yasnippet-snippets xcscope spacemacs-theme skeletor projectile org-download lsp-ui lsp-python ivy-xref hungry-delete ggtags counsel company-shell company-quickhelp company-math company-lsp company-glsl cmake-mode)))
(custom-set-variables
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
