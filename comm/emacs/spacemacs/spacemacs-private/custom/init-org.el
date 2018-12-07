(provide 'init-org)

;; org-mode

(setq org/task "~/org/task/gtd.org")
(setq org/journal "~/org/journal/journal.org")

(setq org-agenda-files
      (list
       org/task
       org/journal))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org/task "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree org/journal)
         "* %?\nEntered on %U\n  %i\n  %a")))

(defun firemiles/open-journal ()
  (interactive)
  (org-open-file org/journal))

(defun firemiles/open-gtd ()
  (interactive)
  (org-open-file org/task))

(defun firemiles/open-financial ()
  (interactive)
  (org-open-file "~/org/finances/finances.org"))

;; set babel languages tye
;; usage:
;; #+BEGIN_SRC ditaa :file some_filename.png :cmdline -r -s 0.8
;; #+BEGIN_SRC plantuml :file export-file-name :cmdline -charset UTF-8
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (ditaa . t)
   (plantuml . t)
   (dot . t)
   (emacs-lisp . t)
   (ruby . t)
   (python . t)
   (shell . t)
   (latex . t)
   (ledger . t)
   ))
(setq org-plantuml-jar-path
      (expand-file-name "3rd/plantuml.jar" dotspacemacs-directory))
(setq org-ditaa-jar-path
      (expand-file-name "3rd/ditaa.jar" dotspacemacs-directory))
;; don't ask when create image.
(setq org-confirm-babel-evaluate nil)
;; Make babel results blocks lowercase
;; create image C-c C-c 
;; preview C-c C-x C-v
(add-hook 'org-babel-after-execute-hook 'firemiles/display-inline-images 'append)
(setq org-babel-results-keyword "RESULTS")

(defun firemiles/display-inline-images ()
  (interactive)
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(defun firemiles/org-insert-screenshot (fullname)
  (interactive "P")
  (setq default-name
        (concat (file-name-directory (buffer-file-name))
                "imgs/"
                (file-name-base (buffer-file-name))
                "_"
                (format-time-string "%Y%m%d_%H%M%S")
                ".png"))

  (setq fullname (read-from-minibuffer "Input image save path: " default-name))
  (unless (file-exists-p (file-name-directory fullname))
    (make-directory (file-name-directory fullname)))

  (call-process "pngpaste" nil nil nil fullname)

  (if (not (file-exists-p fullname))
      (message "Can't find screenshot in clipboard!")

    (insert "#+CAPTION:" (file-name-base fullname) "\n")
    (insert "#+ATTR_ORG: :width 300px\n")
    (insert (concat "[[file:" fullname "]]"))
    (org-display-inline-images)))
