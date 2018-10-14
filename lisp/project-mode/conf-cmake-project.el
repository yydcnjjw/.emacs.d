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

(defvar-local cmake/build-type "Debug")
(defvar-local cmake/build-option "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
(defvar-local cmake/build-dir "debug")

(defun my/cmake-configure-cmd()
  (format "cmake -H. -B%s -DCMAKE_BUILD_TYPE=%s %s" build-dir build-type build-option))
(defun my/cmake-compilation-cmd()
  (format "cmake --build %s" cmake/build-dir))
(defun my/cmake-run-cmd()
  cmake/build-dir)

(projectile-register-project-type 'cmake '("CMakeLists.txt")
                                  :configure 'my/cmake-configure-cmd
                                  :compile 'my/cmake-compilation-cmd
                                  :run 'my/cmake-run-cmd
                                  :test "ctest")
(provide 'conf-cmake-project)
