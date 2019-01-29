;; (setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(setenv "MAGICK_OCL_DEVICE" "OFF")
;; (profiler-start 'cpu)
(require 'load-conf)
;; (profiler-report)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/workspace/GTD/task.org" "~/workspace/notebooks/org/mathematics/papers.org" "~/workspace/GTD/todo.org")) t)
 '(org-download-backend "wget \"%s\" -O \"%s\"")
 '(package-selected-packages
   (quote
    (yasnippet-snippets xcscope web-mode virtualenvwrapper uuidgen spacemacs-theme skeletor pyim posframe paredit-everywhere org-ref org-download org-brain ob-ipython markdown-preview-mode magit lsp-ui ivy-xref ivy-hydra intero hungry-delete groovy-mode graphviz-dot-mode google-translate ghub ggtags geiser flyspell-correct-ivy flycheck-plantuml exec-path-from-shell emmet-mode ein dockerfile-mode docker dart-mode counsel company-quickhelp company-math company-lsp company-glsl company-c-headers comment-tags cmake-mode clang-format chinese-word-at-point cdlatex ccls avy auto-package-update auctex atomic-chrome ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))
