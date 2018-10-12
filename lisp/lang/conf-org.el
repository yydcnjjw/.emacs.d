;; (setq org-image-actual-width (/ (display-pixel-width) 3))
(setq org-startup-indented t)

(set-frame-font my/en-font)
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Noto Sans CJK SC")))

(custom-set-faces
 '(org-table ((t (:family "Noto Sans Mono CJK SC")))))

;; config `org-download'
(require-package 'org-download)
(with-eval-after-load 'org-download
  (setq-default org-download-image-dir "./image")
  ;; (add-hook 'dired-mode-hook 'org-download-enable)
  (define-key org-mode-map (kbd "s-c") 'org-download-screenshot)
  (when (executable-find "spectacle")
    (setq org-download-screenshot-method (format "spectacle -r -b -n -o %s" org-download-screenshot-file)))
  (when (executable-find "wget")
    (custom-set-variables '(org-download-backend "wget \"%s\" -O \"%s\""))))

(require-package 'company-math)
(require-package 'cdlatex)
(require-package 'auctex)
(require-package 'org2ctex)
(defun my/conf-org-latex ()
  (org-cdlatex-mode)
  (setq company-math-allow-latex-symbols-in-faces t)
  (add-hook 'TeX-mode-hook
            (lambda ()
              (my/local-push-company-backend '(company-math-symbols-latex company-yasnippet))
              (org-cdlatex-mode)))
  (setq org-latex-create-formula-image-program 'imagemagick)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq org-format-latex-options (plist-put org-format-latex-options :foreground "White"))
  (setq org-preview-latex-default-process 'imagemagick)
  (defmacro by-backend (&rest body)
    `(case org-export-current-backend ,@body))
  
  (require 'org2ctex)
  (org2ctex-toggle t))

(defun my/conf-org-company ()
  (my/local-push-company-backend '(company-math-symbols-latex company-capf company-yasnippet))
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))

(defun my/conf-org-src-mode ()
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     ;;     (ipython . t)
     (C . t)
     (dot . t)
     (latex . t)
     )))

(require-package 'org-plus-contrib)
(add-hook 'org-mode-hook
          (lambda ()
            (setq truncate-lines nil)
            (org-download-enable)
            (my/conf-org-company)
            (my/conf-org-latex)
            (my/conf-org-src-mode)
            ;; org man link
            (require 'org-man)))

;; export config
(setq-default org-export-with-sub-superscripts '{})

;; GTD
(setq gtd-directory "~/workspace/GTD/")
(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)")))
(setq org-default-notes-file (concat gtd-directory "todo.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-notes-file "Todos")
         "** TODO %?\n%a")))
(setq org-agenda-files
      '("~/workspace/notebooks/org/mathematics/papers.org"
        "~/workspace/GTD/todo.org"
        "~/workspace/GTD/task.org"))

(require-package 'org-ref)
(with-eval-after-load 'org
  (require 'org-ref))
;; org-ref
(setq reftex-default-bibliography '("~/resources/mathematics/bibliography/references.bib"))
(setq org-ref-bibliography-notes "~/workspace/notebooks/org/mathematics/papers.org"
      org-ref-default-bibliography '("~/resources/mathematics/bibliography/references.bib")
      org-ref-pdf-directory "~/resources/mathematics/paper/"
      org-ref-completion-library 'org-ref-ivy-cite)

(defun my/org-ref-open-pdf-at-point ()
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
         (pdf-file (funcall org-ref-get-pdf-filename-function key)))
    (if (file-exists-p pdf-file)
        (shell-command (format "okular %s" pdf-file))
      (message "No PDF found for %s" key))))
(when (executable-find "okular")
  (setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point))

;; override arxiv-get-pdf function
(defun arxiv-get-pdf (arxiv-number pdf)
  "Retrieve a pdf for ARXIV-NUMBER and save it to PDF."
  (interactive "sarxiv: \nsPDF: ")
  (let ((pdf-url (with-current-buffer
                     (url-retrieve-synchronously
                      (concat
                       "http://cn.arxiv.org/abs/" arxiv-number))
                   ;; <meta name="citation_pdf_url" content="http://arxiv.org/pdf/0801.1144" />
                   (goto-char (point-min))
                   (search-forward-regexp
                    "name=\\\"citation_pdf_url\\\" content=\\\"\\(.*\\)\\\"")
                   (match-string 1))))
    (url-copy-file pdf-url pdf)
    ;; now check if we got a pdf
    (if (org-ref-pdf-p pdf)
        (org-open-file pdf)
      (delete-file pdf)
      (message "Error downloading arxiv pdf %s" pdf-url))))

;; org file apps
(with-eval-after-load 'org
  (setcdr (assoc "\\.pdf\\'" org-file-apps) "okular %s"))

(provide 'conf-org)
