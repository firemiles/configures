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
  (add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)
  (setq org-babel-results-keyword "RESULTS")

  (defun bh/display-inline-images ()
    (condition-case nil
      	(org-display-inline-images)
      (error nil)))

(provide 'init-org)
