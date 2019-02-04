;; (setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

;; (setenv "MAGICK_OCL_DEVICE" "OFF")
;; (profiler-start 'cpu)
(require 'load-conf)
;; (profiler-report)
