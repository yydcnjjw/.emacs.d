(require-package 'web-mode)
(require-package 'vue-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
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

(defun my/lsp-web-enable ()
 (setq-local company-lsp-cache-candidates t)
  (my/lsp-enable))

(add-hook 'web-mode-hook #'my/lsp-web-enable)
(add-hook 'css-mode-hook #'my/lsp-web-enable)
(add-hook 'vue-mode-hook #'my/lsp-web-enable)

(defun my/lsp-js-enable ()
  (setq-local company-lsp-cache-candidates t)
  (my/lsp-enable)
  (define-key lsp-ui-mode-map [remap js-find-symbol] #'lsp-ui-peek-find-definitions))
(add-hook 'js-mode-hook #'my/lsp-js-enable)

(require-package 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation

(provide 'conf-web)
