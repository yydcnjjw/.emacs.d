(when (executable-find "dot")
  (require-package 'graphviz-dot-mode)
  (setq graphviz-dot-auto-indent-on-newline t
        graphviz-dot-auto-indent-on-braces nil
        graphviz-dot-auto-indent-on-semi nil
        graphviz-dot-indent-width 2))

(provide 'conf-dot)
