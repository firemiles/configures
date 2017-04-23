;; org-mode
(setq org-agenda-files
      (list "~/org/work.org"
            "~/org/study.org"
            "~/org/gtd.org"
            "~/org/journal.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

(defun firemiles/open-journal ()
  (interactive)
  (org-open-file "~/org/journal.org"))

(defun firemiles/open-gtd ()
  (interactive)
  (org-open-file "~/org/gtd.org"))

(defun firemiles/open-study ()
  (interactive)
  (org-open-file "~/org/study.org"))

(defun firemiles/open-work ()
  (interactive)
  (org-open-file "~/org/work.org"))
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
   (sh . t)
   (latex . t)
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
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(provide 'init-org)
