(defcustom support-languages nil
  ""
  :type 'list)

(when support-languages
  (dolist (list support-languages)
    (require (intern (concat "conf-" list)))
    ))

;; misc
(require-package 'csv-mode)

(provide 'load-lang)
