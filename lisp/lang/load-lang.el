(setq ccls-executable "~/.emacs.d/site-packages/ccls/build/ccls")
(when (executable-find ccls-executable)
  (require 'conf-c-c++))

(require 'conf-python)

(require 'conf-elisp)
(require 'conf-org)
(require 'conf-glsl)
;; (require 'conf-html)
(require 'conf-dot)
;; (require 'conf-js)
;; (require 'conf-java)
(require 'conf-shell)
;; (require 'conf-kotlin)
(require 'conf-md)

(provide 'load-lang)
