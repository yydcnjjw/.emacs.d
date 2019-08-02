(require-package 'popup)
(require-package 'chinese-word-at-point)
(require-package 'google-translate)

(require 'popup)
(require 'chinese-word-at-point)
(require 'google-translate)
(require 'google-translate-smooth-ui)

;; depend jieba
;; elpa `google-translate' `chinese-word-at-ponit'

(setq google-translate-base-url
      "https://translate.google.cn/translate_a/single")
(setq google-translate-listen-url
      "https://translate.google.cn/translate_tts")
(setq google-translate--tkk-url
      "https://translate.google.cn")

(defun google-translate-chinese--region-or-word ()
  (if (use-region-p)
      (buffer-substring-no-properties (region-beginning)
                                      (region-end))
    (thing-at-point 'chinese-or-other-word t)))

(defun google-translate-chinese--bounds-region-or-word ()
  (if (use-region-p)
      (cons (region-beginning) (region-end))
    (bounds-of-thing-at-point 'chinese-or-other-word)))

(defun google-translate-chinese--translate (word)
  (google-translate-json-translation
   (if (chinese-word-cjk-string-p word)
       (google-translate-request "zh-CN" "en" word)
     (google-translate-request "en" "zh-CN" word))))

(defun google-translate-chinese--detailed-translate (word)
  (google-translate-json-detailed-translation
   (if (chinese-word-cjk-string-p word)
       (google-translate-request "zh-CN" "en" word)
     (google-translate-request "en" "zh-CN" word))))

(defun google-translate-chinese-concat-array-as-string (v)
  "Concat strings in v to a whole string."
  (let ((index 0) (str ""))
    (while (< index (length v))
      (setq str (concat str (elt v index) ", "))
      (cl-incf index))
    (substring str 0 (- (length str) 2))))

(defun google-translate-chinese-at-point ()
  "Translate at point and show full result with buffer."
  (interactive)
  (let ((word (google-translate-chinese--region-or-word)))
    (if word
        (if (chinese-word-cjk-string-p word)
            (google-translate-translate "zh-CN" "en" word)
          (google-translate-translate "en" "zh-CN" word))
      ;; (message "Nothing to translate")
      (insert-translated-name-insert "")
      )))

(defun google-translate-chinese-at-point-echo-area ()
  "Translate at point and show only translation in echo area. "
  (interactive)
  (let ((word (google-translate-chinese--region-or-word)))
    (if word
        (message (-translate word))
      ;; (message "Nothing to translate")
      (insert-translated-name-insert "")
      )))

(defun google-translate-chinese-query ()
  "Translate input and show full result with buffer."
  (interactive)
  (let* ((word (google-translate-chinese--region-or-word))
         (word (read-string (format "Translate (%s): "
                                    (or word ""))
                            nil nil
                            word)))
    (if word
        (if (chinese-word-cjk-string-p word)
            (google-translate-request "zh-CN" "en" word)
          (google-translate-request "en" "zh-CN" word))
      (insert-translated-name-insert "")
      ;; (message "Nothing to translate")
      )))

(defun google-translate-chinese-search-at-point-and-replace ()
  (interactive)
  (let ((word (google-translate-chinese--region-or-word))
        (bounds (google-translate-chinese--bounds-region-or-word)))
    (if (and word bounds)
        (let (explains
              popup-list
              (detailed-translate (google-translate-chinese--detailed-translate word))
              selected-item)
          (if (not detailed-translate)
              (progn
                (setq selected-item (popup-menu* (list (popup-make-item (google-translate-chinese--translate word)))))
                (delete-region (car bounds) (cdr bounds))
                (insert selected-item))
            (loop for item across detailed-translate do
                  (let ((index 0))
                    (unless (string-equal (aref item 0) "")
                      (loop for translation across (aref item 1) do
                            (push (format "%d. %s" (incf index) translation) popup-list)
                            (push (concat "<" (substring (aref item 0) 0 1) "> "
                                          (google-translate-chinese-concat-array-as-string (elt (elt (aref item 2) (1- index)) 1)))
                                  popup-list)))))

            (setq popup-list (reverse popup-list))

            (let ((index 0) (a-popup-menu nil))
              (while (< index (length popup-list))
                (push (popup-make-item (nth index popup-list)
                                       :summary (nth (1+ index) popup-list))
                      a-popup-menu)
                (setq index (+ index 2)))
              (setq selected-item (popup-menu* (reverse a-popup-menu)))
              (delete-region (car bounds) (cdr bounds))
              (insert (substring selected-item 3)))))
      ;; (message "Nothing to translate")
      (insert-translated-name-insert "")
      )))

(defun google-translate-chinese-open-word-with-web ()
  (interactive)
  (let ((word (google-translate-chinese--region-or-word))
        from to)
    (if (not word)
        (message "No word found")
      (if (chinese-word-cjk-string-p word)
          (setq from "zh-CN" to "en")
        (setq from "en" to "zh-Cn"))
      (browse-url (concat "https://translate.google.cn/#"
                          from "/" to "/"
                          (url-hexify-string word))))))

(defun google-translate-chinese-search-and-replace ()
  "Search word at point and replace with selected result."
  (interactive)
  (let ((word (thing-at-point 'word t))
        (bounds (bounds-of-thing-at-point 'word))
        selected)
    (if (not (and word bounds))
        ;; (message "Nothing to translate")
        (insert-translated-name-insert "")
      (setq selected (popup-menu* `("item 1" "item 2" ,word)))
      (delete-region (car bounds) (cdr bounds))
      (insert selected))))

(require 'insert-translated-name)
(require 'company-english-helper)
(global-set-key (kbd "C-c C") #'google-translate-chinese-search-at-point-and-replace)
(global-set-key (kbd "C-c M-c") #'toggle-company-english-helper)
(dolist (hook (list
               'org-mode-hook
               'atomic-chrome-edit-mode-hook
               'ein:notebook-multilang-mode-hook
               'markdown-mode-hook
               'text-mode-hook))
  (add-hook
   hook
   #'(lambda ()
       (insert-translated-name-use-original-translation))))

(provide 'conf-translate)
