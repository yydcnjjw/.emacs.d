;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((eval .
             (progn
               (defvar-local build-type "Debug")
               (defvar-local build-option "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_ENABLE_RTTI=on")
               (defvar-local build-dir "debug")
               (setq projectile-project-configure-cmd (format "cmake -H. -B%s -DCMAKE_BUILD_TYPE=%s %s" build-dir build-type build-option))
               (setq projectile-project-compilation-cmd (format "cmake --build %s" build-dir))
               (setq projectile-project-run-cmd (format "%s" build-dir))
               )))))

