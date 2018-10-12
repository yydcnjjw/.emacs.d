(skeletor-define-template "npm-project"
  :title "npm-project"
  :requires-executables '(("node" . "require node")
                          ("npm" . "require npm"))
  :no-license? t
  :substitutions
  '(("__VERSION__" . (lambda ()
                       (let ((version (read-string "Version: ")))
                         (if (string-empty-p version)
                             "1.0.0"
                           version))))
    ("__DESCRIPTION__" . (lambda () (read-string "Description: "))))
  :after-creation
  (lambda (dir)
    (skeletor-async-shell-command "npm install")))

(projectile-register-project-type 'npm '("package.json")
                                  :compile "npm install"
                                  :test "npm test"
                                  :run "npm start"
                                  :test-suffix ".spec")
(provide 'conf-js-project)
