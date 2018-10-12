(when (executable-find "docker")
  (require-package 'docker)
  (require-package 'dockerfile-mode))

(provide 'conf-docker)
