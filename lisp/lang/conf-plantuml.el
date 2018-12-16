(require-package 'plantuml-mode)
(require-package 'flycheck-plantuml)
(setq org-plantuml-jar-path
      (expand-file-name "/opt/plantuml/plantuml.jar")
      plantuml-jar-path
      (expand-file-name "/opt/plantuml/plantuml.jar"))

(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup)
  )
(provide 'conf-plantuml)
