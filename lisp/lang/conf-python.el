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
  (require-package 'pipenv)
  (defvar-local my/python-path '(""))
  (defvar-local my/ld-library-path '(""))
  (add-hook 'venv-postactivate-hook
            #'(lambda ()
                (dolist (path my/python-path)
                  (my/append-env-value "PYTHONPATH" path))
                (dolist (path my/ld-library-path)
                  (my/append-env-value "LD_LIBRARY_PATH" path))
                (my/set-python-jupyter-support)))

  (add-hook 'venv-postdeactivate-hook
            #'(lambda ()
                (setenv "PYTHONPATH" "")
                (setenv "LD_LIBRARY_PATH" ""))))

(my/set-python-lsp-support)
;; (my/set-python-elpy-support)
(my/set-python-jupyter-support)
(my/set-python-venv-support)

(provide 'conf-python)
