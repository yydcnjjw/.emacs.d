(require-package 'elfeed)
(require-package 'elfeed-org)
(require-package 'elfeed-goodies)

(with-eval-after-load 'elfeed
  (setq elfeed-use-curl 't)
  (elfeed-goodies/setup)
  (elfeed-org))

(setq rmh-elfeed-org-files '("~/workspace/notebooks/org/elfeed.org"))

(provide 'conf-feed)
