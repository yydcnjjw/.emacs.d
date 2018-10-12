(skeletor-define-template "python-script-project"
  :title "python-script-project"
  :requires-executables '(("python" . "require python")))

(defun set-python-project-default-configure ()
  (interactive)
  (defvar-local configure-file (concat my/lsp-lib-path "template/python-script-project/.dir-locals.el"))
  (shell-command (format "cp %s %s" configure-file (my/projectile-project-root))))

(provide 'conf-python-project) 
