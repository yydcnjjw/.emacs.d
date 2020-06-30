(require-package 'geiser)
(setq geiser-active-implementations '(guile)
      geiser-chez-binary "scheme"
      geiser-guile-binary "guile")

(add-hook 'scheme-mode-hook 'paredit-mode)

(provide 'conf-scheme)
