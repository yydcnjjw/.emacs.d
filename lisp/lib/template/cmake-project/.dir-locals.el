;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((build-type . "Debug")
       (build-option . "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
       (build-dir . "debug")
       (projectile-project-configure-cmd . (format "cmake -H. -B%s -DCMAKE_BUILD_TYPE=%s %s" build-dir build-type build-option))
       (projectile-project-compilation-cmd . (format "cmake --build %s" build-dir))
       (projectile-project-run-cmd . (format "%s" build-dir)))))
