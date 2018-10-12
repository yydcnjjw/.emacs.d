;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((eval . (progn
        (defvar-local build-type "Debug")
		(defvar-local build-option "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
		(defvar-local build-dir "build/Debug")
		(setq projectile-project-configure-cmd (format "cd %s;cmake %s -DCMAKE_BUILD_TYPE=%s ../.." build-dir build-option build-type))
		(setq projectile-project-compilation-cmd (format "cd %s;cmake --build ." build-dir))
		(setq projectile-project-run-cmd (format "%s" build-dir))
		))))
 (c++-mode
  (c-default-style . linux)
 )
 (c-mode
  (c-default-style . linux))
 )
