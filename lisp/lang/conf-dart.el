(require-package 'dart-mode)
(defun my/lsp-dart-enable ()
  (setq lsp-auto-guess-root t)
  (my/lsp-enable))

(add-hook 'dart-mode-hook 'my/lsp-dart-enable)

(with-eval-after-load "projectile"
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(provide 'conf-dart)
