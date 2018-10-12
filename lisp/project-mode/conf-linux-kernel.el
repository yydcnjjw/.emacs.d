(defvar default-linux-kernel-dir "~/resources/os/linux/linux-kernel/linux-stable")

(my/add-dir-to-view-mode default-linux-kernel-dir)

(projectile-register-project-type 'linux-kernel '("Kbuild" "Makefile"))

(dolist (hook '(asm-mode-hook
                dired-mode-hook))
  (add-hook hook (lambda ()
                   (when (string-equal (symbol-name (projectile-project-type)) "linux-kernel")
                     (require 'xcscope)
                     (cscope-minor-mode 1)))))

(defun view-linux-kernel ()
  (interactive)
  (dired default-linux-kernel-dir))

(provide 'conf-linux-kernel)
