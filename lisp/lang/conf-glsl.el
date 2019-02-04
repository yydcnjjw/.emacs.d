(when (executable-find "glslangValidator")
  (require-package 'company-glsl)
  (add-hook 'glsl-mode-hook
            #'(lambda ()
		(my/local-push-company-backend 'company-glsl))))

(provide 'conf-glsl)
