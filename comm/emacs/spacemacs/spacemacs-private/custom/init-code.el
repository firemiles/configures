(provide 'init-code)

;; yasnippet
(setq yas-snippet-dirs
      '("~/.spacemacs.d/data/yasnippet/snippets"   ;;personal snippets
        ))
(yas-global-mode 1)


;; go mode
(setenv "GOPATH" (concat ""
                         (string-trim (shell-command-to-string "go env GOPATH"))
))

(setenv "GOROOT" (string-trim (shell-command-to-string "go env GOROOT")))
