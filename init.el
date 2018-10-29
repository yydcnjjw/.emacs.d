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
 '(safe-local-variable-values
   (quote
    ((cmake/build-option . "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_ENABLE_RTTI=on")
     (cmake/build-dir . "build")
     (cmake/build-type . "Build")
     (qt/build-file . "translation.pro")
     (qt/build-dir . "build")
     (qt/build-option . "-spec linux-clang")
     (qt/build-type . "Debug")
     (cmake/build-dir . "debug")
     (cmake/build-option . "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
     (cmake/build-type . "Debug")
     (eval my/view-mode-fun)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))
