(require 'conf-projectile)

(defcustom support-projects nil
  ""
  :type 'list)

(when support-projects
  (dolist (list support-projects)
    (require (intern (concat "conf-" list)))))

(provide 'load-project-mode)
