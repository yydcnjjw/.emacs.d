(setq my/org-babel-load-languages
      '((C . t)
	(dot . t)
	(latex . t)
	(plantuml . t)
	(emacs-lisp . t)
	(python . t)))

(defun my/conf-org-attr ()
  (setq org-startup-indented t)
  ;; (dolist (face '(org-level-1
  ;;                 org-level-2
  ;;                 org-level-3
  ;;                 org-level-4
  ;;                 org-level-5))
  ;;   (set-face-attribute face nil
  ;; 			:height 1.0))
  (set-face-attribute 'org-table nil
                      :family "Noto Sans Mono CJK SC"))

;; config `org-download'
(require-package 'org-download)
(with-eval-after-load 'org-download
  (setq org-download-image-dir "./image"
        org-download-timestamp "-%Y-%m-%d-%H-%M-%S")
  (define-key org-mode-map (kbd "s-c") 'org-download-screenshot)

  (when (executable-find "spectacle")
    (setq org-download-screenshot-method
          (format "spectacle -r -b -n -o %s" org-download-screenshot-file)))
  (when (executable-find "wget")
    (setq org-download-backend "wget \"%s\" -O \"%s\"")))

(require-package 'company-math)
(require-package 'cdlatex)
(require-package 'auctex)
(defun my/conf-org-latex ()
  (org-cdlatex-mode)
  (setq company-math-allow-latex-symbols-in-faces t)
  (add-hook 'TeX-mode-hook
            #'(lambda ()
                (my/local-push-company-backend '(company-math-symbols-latex company-yasnippet))
                (org-cdlatex-mode)))

  (add-to-list 'org-preview-latex-process-alist
               '(my-imagemagick
                 :programs ("latex" "convert")
                 :description "pdf > png"
                 :message "you need to install the programs: latex and imagemagick."
                 :use-xcolor t
                 :image-input-type "pdf"
                 :image-output-type "png"
                 :image-size-adjust (1.0 . 1.0)
                 :latex-compiler ("xelatex -interaction nonstopmode -output-directory %o %f")
                 :image-converter
                 ("convert -density %D -trim -antialias %f -quality 100 %O")))

  (setq org-format-latex-options
        '(:foreground "White" :background default :scale 1.4
		      :html-foreground "Black" :html-background "Transparent"
		      :html-scale 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  (setq org-latex-default-packages-alist
        '(("AUTO" "inputenc"  t ("pdflatex"))
          ("T1"   "fontenc"   t ("pdflatex"))
          (""     "graphicx"  t)
          (""     "grffile"   t)
          (""     "longtable" nil)
          (""     "wrapfig"   nil)
          (""     "rotating"  nil)
          ("normalem" "ulem"  t)
          (""     "amsmath"   t)
          (""     "textcomp"  t)
          (""     "amssymb"   t)
          (""     "capt-of"   nil)
          (""     "hyperref"  nil)))
  ;; org latex preview
  (setq org-preview-latex-default-process 'my-imagemagick
        org-latex-compiler "xelatex")

  (setq org-latex-pdf-process
        '("%latex -interaction nonstopmode -output-directory %o %f"
          "%latex -interaction nonstopmode -output-directory %o %f"
          "%latex -interaction nonstopmode -output-directory %o %f"))
  (defmacro by-backend (&rest body)
    `(case org-export-current-backend ,@body)))

(defun my/conf-org-company ()
  (my/local-push-company-backend '(company-math-symbols-latex company-capf company-yasnippet))
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))

(defun my/conf-ob-ipython ()
  (require-package 'ob-ipython)
  (add-hook 'venv-postactivate-hook
	    #'(lambda ()
		(when (eq major-mode 'org-mode)
		  (add-to-list 'my/org-babel-load-languages '(ipython . t))
		  (org-babel-do-load-languages
		   'org-babel-load-languages
		   my/org-babel-load-languages))))
  (add-hook 'ob-ipython-mode-hook
            #'(lambda ()
                (my/local-push-company-backend '(company-ob-ipython)))))

(my/conf-ob-ipython)

(defun my/conf-org-src-mode ()
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
  (org-babel-do-load-languages
   'org-babel-load-languages
   my/org-babel-load-languages))

(defun my/org-man-link ()
  (org-link-set-parameters "man"
			   :follow #'org-man-open
			   :export #'org-man-export
			   :store #'org-man-store-link)
  (defcustom org-man-command 'man
    "The Emacs command to be used to display a man page."
    :group 'org-link
    :type '(choice (const man) (const woman)))

  (defun org-man-open (path)
    "Visit the manpage on PATH.
PATH should be a topic that can be thrown at the man command."
    (funcall org-man-command path))

  (defun org-man-store-link ()
    "Store a link to a README file."
    (when (memq major-mode '(Man-mode woman-mode))
      ;; This is a man page, we do make this link
      (let* ((page (org-man-get-page-name))
             (link (concat "man:" page))
             (description (format "Manpage for %s" page)))
        (org-store-link-props
         :type "man"
         :link link
         :description description))))

  (defun org-man-get-page-name ()
    "Extract the page name from the buffer name."
    ;; This works for both `Man-mode' and `woman-mode'.
    (if (string-match " \\(\\S-+\\)\\*" (buffer-name))
        (match-string 1 (buffer-name))
      (error "Cannot create link to this man page")))

  (defun org-man-export (link description format)
    "Export a man page link from Org files."
    (let ((path (format "http://man.he.net/?topic=%s&section=all" link))
	  (desc (or description link)))
      (cond
       ((eq format 'html) (format "<a target=\"_blank\" href=\"%s\">%s</a>" path desc))
       ((eq format 'latex) (format "\\href{%s}{%s}" path desc))
       ((eq format 'texinfo) (format "@uref{%s,%s}" path desc))
       ((eq format 'ascii) (format "%s (%s)" desc path))
       (t path)))))

;; export config
(setq org-export-with-sub-superscripts '{})

;; GTD
(setq gtd-directory "~/workspace/GTD/"
      org-todo-keywords '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)"))
      org-default-notes-file (concat gtd-directory "todo.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-notes-file "Todos")
         "** TODO %?\n%a")))
(setq org-agenda-files
      '("~/workspace/GTD/todo.org"
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

;; org brain
(require-package 'org-brain)
(setq org-brain-path "~/workspace/GTD/brain/"
      org-id-track-globally t
      org-brain-visualize-default-choices 'all
      org-brain-title-max-length 12)
(push '("b" "Brain" plain (function org-brain-goto-end)
        "* %i%?" :empty-lines 1)
      org-capture-templates)

;; org complete bug
;; do not complete 
;; (require-package 'org-plus-contrib)
(add-hook 'org-mode-local-vars-hook
          #'(lambda ()
              (setq truncate-lines nil)
              (my/conf-org-attr)
              (org-download-enable)
              (my/conf-org-company)
              (my/conf-org-latex)
              (my/conf-org-src-mode)
              ;; org man link
              (my/org-man-link)
              ;; (require 'org-man)
              ))

(provide 'conf-org)
