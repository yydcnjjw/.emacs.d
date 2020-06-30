;;; init.el --- init -*- lexical-binding: t -*-

;; Author: yydcnjjw
;; Maintainer: yydcnjjw
;; Version: version
;; Package-Requires: (dependencies)
;; Homepage: homepage
;; Keywords: keywords


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; commentary

;;; Code:

;; (setq debug-on-error t)
(defconst emacs-user-conf-dir (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'load-path emacs-user-conf-dir)
(let ((default-directory (file-name-as-directory emacs-user-conf-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(require 'load-conf)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/workspace/school/毕业设计/paper.org" "~/workspace/GTD/todo.org" "~/workspace/GTD/task.org" "~/workspace/notebooks/org/todo.org")))
 '(package-selected-packages
   (quote
    (paredit org-drill org-contrib pipenv anki-editor lsp-python-ms company-lsp counsel ivy-hydra ivy-xref skeletor ag ibuffer-projectile csv-mode nasm-mode yaml-mode flycheck-plantuml plantuml-mode markdown-preview-mode graphviz-dot-mode company-glsl groovy-mode lua-mode org-ref ob-ipython auctex cdlatex company-math org-download slime-company slime geiser intero haskell-mode dart-mode protobuf-mode emmet-mode flycheck-pos-tip rjsx-mode tide typescript-mode vue-mode company-web web-mode go-mode lsp-java ein polymode cmake-mode company-c-headers ggtags xcscope clang-format ccls restclient wanderlust shimbun mew elfeed-goodies elfeed-org elfeed pdf-tools dockerfile-mode docker google-translate chinese-word-at-point flyspell-correct-ivy yasnippet-snippets yasnippet flycheck lsp-ui lsp-mode company-quickhelp company expand-region exec-path-from-shell atomic-chrome posframe pyim comment-tags treemacs-projectile treemacs-magit treemacs highlight-numbers spacemacs-theme ht))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
