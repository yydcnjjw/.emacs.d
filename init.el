(setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(require 'load-conf)
(setenv "MAGICK_OCL_DEVICE" "OFF")

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-agenda-files
;;    (quote
;;     ("~/workspace/notebooks/org/mathematics/papers.org" "~/workspace/GTD/todo.org" "~/workspace/GTD/task.org")))
;;  '(package-selected-packages
;;    (quote
;;     (use-package magit-todos ccls org-plus-contrib markdown-preview-mode ein flyspell-correct-ivy google-translate atomic-chrome posframe pyim lsp-vue vue-mode lsp-clangd kotlin-mode lsp-intellij lsp-html js2-mode json-mode chinese-word-at-point ag comment-tags org-ref virtualenvwrapper magit org2ctex graphviz-dot-mode web-mode company-restclient restclient clang-format htmlize cdlatex auctex avy-flycheck yasnippet-snippets xcscope spacemacs-theme skeletor projectile org-download lsp-ui lsp-python ivy-xref hungry-delete ggtags counsel company-shell company-quickhelp company-math company-lsp company-glsl cmake-mode)))
;;  '(safe-local-variable-values
;;    (quote
;;     ((my/ld-library-path "/home/yydcnjjw/resources/mathematics/venv/site-packages/pytorch/build/lib")
;;      (my/python-path "/home/yydcnjjw/resources/mathematics/venv/site-packages/pytorch/build")
;;      (my/venv . "pytorch-py2")
;;      (eval progn
;;            (setq projectile-project-configure-cmd "")
;;            (setq projectile-project-compilation-cmd "")
;;            (setq projectile-project-run-cmd "python "))
;;      (eval progn
;;            (defvar-local build-type "Debug")
;;            (defvar-local build-option "-spec linux-clang")
;;            (defvar-local build-dir "build")
;;            (setq projectile-project-configure-cmd
;;                  (format "cd %s;qmake ../translation.pro %s" build-dir build-option))
;;            (setq projectile-project-compilation-cmd
;;                  (format "cd %s;bear make" build-dir))
;;            (setq projectile-project-run-cmd
;;                  (format "%s" build-dir)))
;;      (eval my/view-mode-fun)
;;      (eval progn
;;            (defvar-local build-type "Debug")
;;            (defvar-local build-option "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
;;            (defvar-local build-dir "build/Debug")
;;            (setq projectile-project-configure-cmd
;;                  (format "cd %s;cmake %s -DCMAKE_BUILD_TYPE=%s ../.." build-dir build-option build-type))
;;            (setq projectile-project-compilation-cmd
;;                  (format "cd %s;cmake --build ." build-dir))
;;            (setq projectile-project-run-cmd
;;                  (format "%s" build-dir))))))
;;  '(tool-bar-mode nil))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-table ((t (:family "Noto Sans Mono CJK SC")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dockerfile-mode dcokerfile-mode posframe magit yasnippet-snippets skeletor ag markdown-preview-mode company-shell graphviz-dot-mode company-glsl org-ref yasnippet xcscope virtualenvwrapper spacemacs-theme pyim org2ctex org-plus-contrib org-download lsp-ui ivy-xref hungry-delete google-translate flyspell-correct-ivy ein counsel company-quickhelp company-math company-lsp comment-tags cmake-mode chinese-word-at-point cdlatex ccls avy auto-package-update auctex atomic-chrome))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))
