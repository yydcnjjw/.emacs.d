(require-package 'slime)
(require-package 'slime-company)

(setq inferior-lisp-program "sbcl")
(setq slime-contribs '(slime-fancy
                       slime-company))

(provide 'conf-common-lisp)
