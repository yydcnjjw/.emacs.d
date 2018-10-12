(require 'conf-projectile)

(defcustom support-projects nil
  ""
  :type 'list)

(when support-projects
  (dolist (list support-languages)
    (require list)
    ))

(provide 'load-project-mode)
