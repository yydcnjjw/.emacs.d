;; (setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(setenv "MAGICK_OCL_DEVICE" "OFF")
(require 'load-conf)
(custom-set-variables
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
