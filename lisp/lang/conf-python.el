(defun my/set-python-shell-interpreter()
  (when (executable-find "ipython")
    (make-local-variable 'python-shell-interpreter)
    (make-local-variable 'python-shell-interpreter-args)
    (setq python-shell-interpreter "ipython"
          python-shell-interpreter-args "--simple-prompt -i")))

(defun my/set-python-lsp-support()
  (when (executable-find "pyls")
    (defun my/lsp-python-enable ()
      (setq company-transformers nil
            company-lsp-async t
            company-lsp-cache-candidates t)
      (my/lsp-enable))
    (add-hook 'python-mode-local-vars-hook #'my/lsp-python-enable)
    (when (eq major-mode 'python-mode)
      (my/lsp-python-enable))))

(defun my/set-python-jupyter-support()
  "jupyter support"
  (when (executable-find "jupyter")
    (require-package 'ein)
    (setq ein:completion-backend 'ein:use-company-backend)
    (add-hook 'ein:connect-mode-hook
              (lambda ()
                ;; Fix ein overriding find-define key in python-mode
                (when (eq major-mode 'python-mode)
                  (define-key lsp-ui-mode-map [remap ein:pytools-jump-to-source-command] #'lsp-ui-peek-find-definitions))))))

(my/set-python-shell-interpreter)
(my/set-python-lsp-support)
(my/set-python-jupyter-support)

(setq enable-python-env t)
(if (executable-find "virtualenv")
    (progn 
      (require-package 'virtualenvwrapper)
      ;; (venv-initialize-eshell)
      ;; (venv-initialize-interactive-shells)
      (setq venv-location "~/resources/mathematics/venv/")
      (add-hook 'venv-postactivate-hook #'my/set-python-shell-interpreter)
      (setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))
      
      (defvar-local my/venv "python3")
      (defvar-local my/python-path '(""))
      (defvar-local my/ld-library-path '(""))
      (add-hook 'venv-postactivate-hook
                (lambda ()
                  (dolist (path my/python-path)
                    (my/append-env-value "PYTHONPATH" path))
                  (dolist (path my/ld-library-path)
                    (my/append-env-value "LD_LIBRARY_PATH" path))
                  (my/set-python-shell-interpreter)
                  (my/set-python-lsp-support)
                  (my/set-python-jupyter-support)))

      (add-hook 'venv-postdeactivate-hook
                (lambda ()
                  (setenv "PYTHONPATH" "")
                  (setenv "LD_LIBRARY_PATH" "")))
      (add-hook 'python-mode-local-vars-hook
                (lambda ()
                  (when (and enable-python-env my/venv)
                    (venv-workon my/venv)))))
  (progn
    (message "option: require virtualenv")
    (setq enable-python-env nil)))

(provide 'conf-python)
