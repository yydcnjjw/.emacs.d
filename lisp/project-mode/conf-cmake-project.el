(skeletor-define-template "cmake-project"
  :title "cmake-project"
  :requires-executables '(("cmake" . "require cmake"))
  :after-creation
  (lambda (dir)
    (skeletor-async-shell-command (format
				   "cd build/Debug;cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON %s;ln -s %s/build/Debug/compile_commands.json %s/compile_commands.json" dir dir dir))))

(defun my/set-cmake-project-default-configure ()
  (interactive)
  (defvar-local configure-file (concat my/lisp-lib-path "template/cmake-project/.dir-locals.el"))
  (shell-command (format "cp %s %s" configure-file (my/projectile-project-root))))

(provide 'conf-cmake-project)
