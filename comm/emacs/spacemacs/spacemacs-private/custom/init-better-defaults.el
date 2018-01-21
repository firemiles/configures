(provide 'init-better-defaults)

(global-visual-line-mode 1)
(global-linum-mode 1)

;; setting font
;; (spacemacs//set-monospaced-font "Menlo" "PingFang" 13 15) ;; need chinese layer

(setq chinese-font "Consolas")
(cond ((eq system-type 'darwin) (setq chinese-font "PingFang SC"))
      ((eq system-type 'windows-nt) (setq chinese-font "Hiragino Sans GB")))

(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family chinese-font :size 16)))

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
