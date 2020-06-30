(require-package 'plantuml-mode)
(require-package 'flycheck-plantuml)
(setq org-plantuml-jar-path
      (expand-file-name "/usr/share/java/plantuml/plantuml.jar")
      plantuml-jar-path
      (expand-file-name "/usr/share/java/plantuml/plantuml.jar")
      plantuml-default-exec-mode 'jar)

(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup)
  )
(provide 'conf-plantuml)
