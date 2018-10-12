(defcustom support-languages nil
  ""
  :type 'list)

(when support-languages
  (dolist (list support-languages)
    (require (intern (concat "conf-" list)))
  ))

;; (require 'conf-html)
;; (require 'conf-js)
;; (require 'conf-java)
;; (require 'conf-kotlin)

(provide 'load-lang)
