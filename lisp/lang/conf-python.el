(defun my/set-python-shell-interpreter()
  (when (executable-find "ipython")
    (make-local-variable 'python-shell-interpreter)
    (make-local-variable 'python-shell-interpreter-args)
    (setq python-shell-interpreter "ipython"
          python-shell-interpreter-args "--simple-prompt -i")))

(defun my/set-python-lsp-support()
  (defun my/lsp-python-enable ()
    (require-package 'lsp-python-ms)
    (require 'lsp-python-ms)
    (my/lsp-enable))
  (add-hook 'python-mode-local-vars-hook #'my/lsp-python-enable))

(defun my/set-python-elpy-support ()
  (require-package 'elpy)
  (elpy-enable))

(defun my/set-python-jupyter-support()
  "jupyter support"
  (require-package 'polymode)
  (require-package 'ein)
  (when (executable-find "jupyter")
    (setq ein:completion-backend 'ein:use-company-backend)
    (add-hook 'ein:connect-mode-hook
              #'(lambda ()
                  ;; Fix ein overriding find-define key in python-mode
                  (when (eq major-mode 'python-mode)
                    (define-key lsp-ui-mode-map [remap ein:pytools-jump-to-source-command] #'lsp-ui-peek-find-definitions))))))

(defun my/set-python-venv-support ()
  (when (executable-find "virtualenv")
    (require-package 'virtualenvwrapper)
    (setq venv-location "~/resources/mathematics/venv/")
    (add-hook 'venv-postactivate-hook #'my/set-python-shell-interpreter)
    (setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))

    (defvar-local my/venv "python3")
    (defvar-local my/python-path '(""))
    (defvar-local my/ld-library-path '(""))
    (add-hook 'venv-postactivate-hook
              #'(lambda ()
                  (dolist (path my/python-path)
                    (my/append-env-value "PYTHONPATH" path))
                  (dolist (path my/ld-library-path)
                    (my/append-env-value "LD_LIBRARY_PATH" path))
                  (my/set-python-shell-interpreter)
                  (my/set-python-jupyter-support)))

    (add-hook 'venv-postdeactivate-hook
              #'(lambda ()
                  (setenv "PYTHONPATH" "")
                  (setenv "LD_LIBRARY_PATH" "")))
    (add-hook 'python-mode-local-vars-hook
              #'(lambda ()
                  (venv-projectile-auto-workon)
                  (unless venv-current-name
                    (when my/venv
                      (venv-workon my/venv)))))))

(my/set-python-shell-interpreter)
(my/set-python-lsp-support)
;; (my/set-python-elpy-support)
(my/set-python-jupyter-support)
(my/set-python-venv-support)

(provide 'conf-python)
