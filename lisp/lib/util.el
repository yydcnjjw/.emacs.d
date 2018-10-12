(defvar system-tags-url "~/resources/basic/tags/SYSTAGS")
(defconst my/lisp-lib-path "~/.emacs.d/lisp/lib/")

(defun my/disable-minor-modes (minor-list)
  (dolist (mode minor-list)
              (when mode
                (funcall mode -1))))

(defun my/add-hook-prog-and-text-mode (fun)
  "add hook to prog and text mode"
  (add-hook 'prog-mode-hook fun)
  (add-hook 'text-mode-hook fun))

(add-hook 'hack-local-variables-hook 'my/run-local-vars-mode-hook)
(defun my/run-local-vars-mode-hook ()
  "Run a hook for the major-mode after the local variables have been processed."
  (run-hooks (intern (concat (symbol-name major-mode) "-local-vars-hook"))))

(defun my/append-env-value (env value)
  (setenv env (concat value ":" (getenv env))))

(provide 'util)
