(setq package-archives
      '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(setq package-enable-at-startup nil)
(package-initialize)

(defun require-package (package &optional min-version no-refresh)
  (or (package-installed-p package min-version)
      (if (or no-refresh (assoc package package-archive-contents))
          (package-install package)
        (progn
          (package-refresh-contents)
          (require-package package min-version t)))))

(require-package 'auto-package-update)
(with-eval-after-load 'auto-package-update
  (setq auto-package-update-interval 1)
  (setq auto-package-update-delete-old-versions t)
  ;; (setq auto-package-update-hide-results t)
  ;; (setq auto-package-update-prompt-before-update t)
  )
(add-hook 'after-init-hook #'auto-package-update-maybe)

(provide 'init-package)
