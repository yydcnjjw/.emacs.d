;; (defun my/lsp-java-enable ()
;;   (require 'lsp-intellij)
;;   (setq c-basic-offset 4)
;;   (my/configure-lsp-company)
;;   (lsp-intellij-enable))

;; (add-hook 'java-mode-hook #'my/lsp-java-enable)
;; (add-hook 'kotlin-mode-hook #'my/lsp-java-enable)


(defcustom jkls-executable
  "/home/yydcnjjw/workspace/code/project/jkls/jkls-main/build/libs/jkls-main-1.0-SNAPSHOT-all.jar"
  "Install directory for jkls")

(defun jkls-command ()
  `("java"
    "-jar"
    ,jkls-executable
    ))

(defun my/lsp-java-enable ()
  (require 'lsp-mode)
  (require 'lsp-clients)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection 'jkls-command)
                    :major-modes '(java-mode)
                    :priority 1
                    :server-id 'jkls
		    :initialization-options '(:cacheDir "/home/yydcnjjw/.cache")))
  (my/lsp-enable))

;; (add-hook 'java-mode-hook 'my/lsp-java-enable)


(require-package 'lsp-java)
(require 'lsp-java)
(require 'lsp-java-boot)

(add-hook 'java-mode-hook
          #'(lambda ()
              (my/lsp-enable)
              (lsp-lens-mode)
              (lsp-java-boot-lens-mode)))

(provide 'conf-java)
