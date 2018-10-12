;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((eval . (progn
		 (setq projectile-project-compilation-cmd "npm install"
                       projectile-project-run-cmd "npm start"
                       projectile-project-test-cmd "npm test")
		 ))))
 ("node_modules/"
  . ((nil . ((eval . (my/view-mode-writeable-fun)))))))

