(when (executable-find "dot")
  (require-package 'graphviz-dot-mode)
  (with-eval-after-load 'graphviz-dot-mode
    (setq graphviz-dot-auto-indent-on-newline t
          graphviz-dot-auto-indent-on-braces t
          graphviz-dot-auto-indent-on-semi t
          graphviz-dot-indent-width 2)))

(provide 'conf-dot)
