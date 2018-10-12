;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((eval . (progn
		 (setq projectile-project-compilation-cmd "./gradlew build"
                       projectile-project-configure-cmd "./gradlew tasks"
                       projectile-project-run-cmd "./gradlew run"
                       projectile-project-test-cmd "./gradlew test")
		 )))))

