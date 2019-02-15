(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))

(setq web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2

      web-mode-enable-current-column-highlight t
      web-mode-enable-current-element-highlight t
      
      web-mode-enable-auto-pairing t
      web-mode-enable-css-colorization t
      web-mode-enable-block-face t
      web-mode-enable-part-face t
      web-mode-enable-comment-interpolation t)

(require-package 'company-web)
;;; `html' `css'
(defun my/company-web-configure ()
  (let ((file-extension (file-name-extension buffer-file-name)))
    (when (or (string= "html" file-extension)
	      (string= "css" file-extension))
      (my/local-push-company-backend '(company-css company-web-html company-yasnippet company-files)))
    ))
(add-hook 'web-mode-hook #'my/company-web-configure)

;;; `vue-mode'
(require-package 'vue-mode)
(defun my/lsp-vue-enable ()
  (setq-local company-lsp-cache-candidates t)
  (my/lsp-enable))
(add-hook 'vue-mode-hook #'my/lsp-vue-enable)

;; js ts tsx jsx
(require-package 'tide)
(require-package 'flycheck-pos-tip)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (flycheck-pos-tip-mode)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (local-set-key (kbd "M-RET") #'tide-fix)
  (when (eq major-mode 'js2-mode)
    (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)))
(setq tide-completion-detailed t
      tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode)
(add-hook 'web-mode-hook
          #'(lambda ()
	      (let ((file-extension (file-name-extension buffer-file-name)))
		(cond
		 ((string-equal "tsx" file-extension)
		  (setup-tide-mode)
		  (flycheck-add-mode 'typescript-tslint 'web-mode))
		 ((string-equal "jsx" file-extension)
		  (setup-tide-mode)
		  (flycheck-add-mode 'javascript-eslint 'web-mode)
		  (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
		  )))))


;FIXME: [tsserver] /usr/bin/npm not found
;;; ln -s /usr/bin/npm npm
;; (require-package 'typescript-mode)
;; (defun my/lsp-js-enable ()
;;   (setq-local company-lsp-cache-candidates t)
;;   (my/lsp-enable)
;;   (define-key lsp-ui-mode-map [remap js-find-symbol] #'lsp-ui-peek-find-definitions))
;; (add-hook 'js-mode-hook #'my/lsp-js-enable)
;; (add-hook 'typescript-mode-hook #'my/lsp-js-enable)

;;; `emmet'
(require-package 'emmet-mode)
(add-hook 'web-mode-hook #'emmet-mode)
(add-hook 'sgml-mode-hook #'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  #'emmet-mode) ;; enable Emmet's css abbreviation
(add-hook 'web-mode-before-auto-complete-hooks
    #'(lambda ()
	(let ((web-mode-cur-language
  	       (web-mode-language-at-pos)))
          (if (string= web-mode-cur-language "css")
    	      (setq emmet-use-css-transform t)
      	    (setq emmet-use-css-transform nil)))))
(provide 'conf-web)
