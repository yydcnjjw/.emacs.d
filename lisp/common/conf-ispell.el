(setq ispell-local-dictionary "en_US")
(cond
 ((executable-find "aspell")
  ;; you may also need `ispell-extra-args'
  (setq ispell-program-name "aspell"))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))
 (t (setq ispell-program-name nil)))

(defun flyspell-detect-ispell-args (&optional run-together)
  "if RUN-TOGETHER is true, spell check the CamelCase words."
  (let (args)
    (cond
     ((string-match  "aspell$" ispell-program-name)
      (setq args (list "--sug-mode=ultra" "--lang=en_US"))
      (if run-together
          (setq args (append args '("--run-together")))))
     ((string-match "hunspell$" ispell-program-name)
      (setq args "-d en_US"))
     args)))
(setq-default ispell-extra-args (flyspell-detect-ispell-args t))

(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'text-mode-hook #'flyspell-mode)
(with-eval-after-load 'flyspell
  (require-package 'flyspell-correct-ivy)
  (require 'flyspell-correct-ivy)
  (define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-wrapper))

(provide 'conf-ispell)
