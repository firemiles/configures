(global-visual-line-mode 1)
(global-linum-mode 1)

;; setting font
(spacemacs//set-monospaced-font "Menlo" "PingFang" 13 15)

;; setting time stamp format to English
(setq system-time-locale "C")

;; delete selection when edit
(delete-selection-mode t)

;; open fullscreen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

(defun firemiles/remove-dos-eol ()
  "replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; add shell path to emacs
(exec-path-from-shell-arguments)

(provide 'init-better-defaults)
