(require-package 'dart-mode)

(defun my/lsp-dart-enable ()
  (setq lsp-auto-guess-root t)
  (my/lsp-enable))

(add-hook 'dart-mode-hook #'my/lsp-dart-enable)

(with-eval-after-load 'projectile
  (projectile-register-project-type 'dart '("pubspec.yaml")
                                    :run "flutter run"))

(provide 'conf-dart)
