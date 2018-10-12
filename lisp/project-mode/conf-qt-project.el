(defun projectile-qt-project-p ()
  "Check if a project contains qt pro files."
  (projectile-verify-file-wildcard "*.pro"))

(projectile-register-project-type 'qt-project #'projectile-qt-project-p)

(skeletor-define-template "qt-project"
  :title "qt-project"
  :requires-executables '(("qmake" . "require qmake"))
  :after-creation
  (lambda (dir)
    (skeletor-async-shell-command (format
				   "ln -s %s/build/Debug/compile_commands.json %s/compile_commands.json" dir dir))))


(provide 'conf-qt-project)
