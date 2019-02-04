(require-package 'paredit)
(require-package 'geiser)
(setq geiser-active-implementations '(chez racket)
      geiser-chez-binary "chez-scheme")

(add-hook 'scheme-mode-hook
          #'(lambda ()
              (paredit-mode 1)))
(provide 'conf-scheme)
