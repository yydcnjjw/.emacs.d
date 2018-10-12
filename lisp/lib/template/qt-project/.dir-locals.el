;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((eval . (progn
        (defvar-local build-type "Debug")
		(defvar-local build-option "-spec linux-clang")
		(defvar-local build-dir "build/Debug")
		(setq projectile-project-configure-cmd (format "cd %s;qmake ../../__PROJECT-NAME__.pro %s" build-dir build-option))
		(setq projectile-project-compilation-cmd (format "cd %s;bear make" build-dir))
		(setq projectile-project-run-cmd (format "%s" build-dir))
		))))
 (c++-mode
  (c-default-style . linux)
 )
 (c-mode
  (c-default-style . linux))
 )
