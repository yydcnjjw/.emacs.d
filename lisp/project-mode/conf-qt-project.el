(defun projectile-qt-project-p ()
  "Check if a project contains qt pro files."
  (projectile-verify-file-wildcard "*.pro"))

(defvar-local qt/build-type "Debug")
(defvar-local qt/build-option "-spec linux-clang")
(defvar-local qt/build-dir "debug")
(defvar-local qt/build-file nil)

(defun my/qt-configure-cmd()
  (if qt/build-file
      (format "cd %s;qmake ../%s %s" qt/build-dir qt/build-file qt/build-option)
    (message "require build file")))
(defun my/qt-compilation-cmd()
  (format "cd %s;bear make" qt/build-dir))
(defun my/qt-run-cmd()
  qt/build-dir)

(projectile-register-project-type 'qt-project #'projectile-qt-project-p
                                  :configure 'my/qt-configure-cmd
                                  :compile 'my/qt-compilation-cmd
                                  :run 'my/qt-run-cmd)

(skeletor-define-template "qt-project"
  :title "qt-project"
  :requires-executables '(("qmake" . "require qmake"))
  :after-creation
  (lambda (dir)
    (skeletor-async-shell-command (format
				   "ln -s %s/debug/compile_commands.json %s/compile_commands.json" dir dir))))


(provide 'conf-qt-project)
