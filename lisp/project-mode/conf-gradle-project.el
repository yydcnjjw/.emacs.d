(setq gradle-project-types
      '("java-application"
        "java-library"
        "scala-library"
        "groovy-library"
        "basic"))

(skeletor-define-template "gradle-project"
    :title "gradle-project"
    :requires-executables '(("gradle" . "require gradle"))
    :after-creation
    (lambda (dir)
      (let ((project-type (ivy-completing-read "gradle-project-type: " gradle-project-types))
            (dsl (if (yes-or-no-p "dsl(default kotlin)")
                     "--dsl kotlin"
                   "")))
        (skeletor-async-shell-command (format "gradle init --type %s %s" project-type dsl)))))

(defun my/set-gradle-project-default-configure ()
  (interactive)
  (let ((gradle-project-template-dir
         (concat my/lisp-lib-path "template/gradle-project/"))
        (gradle-project-template-files ""))
    (dolist (file '(".dir-locals.el"
                    ".projectile"))
      (setq gradle-project-template-files
            (concat gradle-project-template-dir file " " gradle-project-template-files)))
    (shell-command (format "cp %s %s" gradle-project-template-files
                           (my/projectile-project-root)))))

(provide 'conf-gradle-project)
