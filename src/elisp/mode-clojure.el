;; Clojure specific settings
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'yas-minor-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'clj-refactor-mode)

(defun e:cider-kill-server ()
  "Kill cider server"
  (interactive))

(evil-leader/set-key-for-mode 'clojure-mode "s i" 'cider-jack-in)
(evil-leader/set-key-for-mode 'clojure-mode "s s" 'cider-switch-to-repl-buffer)
(evil-leader/set-key-for-mode 'clojure-mode "s r" 'cider-restart)
(evil-leader/set-key-for-mode 'clojure-mode "s q" 'cider-quit)
(evil-leader/set-key-for-mode 'clojure-mode "r a r" 'cljr-add-require-to-ns)
(evil-leader/set-key-for-mode 'clojure-mode "r a i" 'cljr-add-import-to-ns)
(evil-leader/set-key-for-mode 'clojure-mode "r a p" 'cljr-add-project-dependency)
(evil-leader/set-key-for-mode 'clojure-mode "r a m" 'cljr-add-missing-libspec)
(evil-leader/set-key-for-mode 'cider-repl-mode "s s" 'cider-switch-to-last-clojure-buffer)
(evil-leader/set-key-for-mode 'cider-repl-mode "s c" 'cider-repl-clear-buffer)
(evil-leader/set-key-for-mode 'cider-repl-mode "s r" 'cider-restart)
(evil-leader/set-key-for-mode 'cider-repl-mode "s q" 'cider-quit)
(define-key clojure-mode-map (kbd "M-/") 'hippie-expand)

(setq cljr-suppress-middleware-warnings t
      e:lein-profile-path "~/.lein/profiles.clj"
      e:lein-plugins '(("refactor-nrepl" "2.4.1-SNAPSHOT")))

(defun e:stringify-lein-plugin (plugin)
  (format "[%s \"%s\"]"
          (first plugin)
          (second plugin)))

(defun e:create-lein-profile (path plugins)
  (with-temp-file path
    (let* ((base "{:user {:plugins [")
           (len (length base))
           (indent (make-string len ?\ )))
      (insert base)
      (insert (e:stringify-lein-plugin (first plugins)))
      (mapcar (lambda (plugin)
                (insert (format "\n%s" indent))
                (insert (e:stringify-lein-plugin plugin)))
              (cdr plugins))
      (insert "]}}\n"))))

(when (not (file-exists-p e:lein-profile-path))
  (e:create-lein-profile e:lein-profile-path
                         e:lein-plugins))
