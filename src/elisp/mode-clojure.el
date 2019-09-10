;; Clojure specific settings
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'yas-minor-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'clj-refactor-mode)
(add-hook 'cider-mode-hook 'eldoc-mode)

(defun +clojure/cider-kill-server ()
  "Kill cider server"
  (interactive))

(evil-leader/set-key-for-mode 'clojure-mode "e g" '+clojure/generate-etags)
(evil-leader/set-key-for-mode 'clojure-mode "f s" '+clj/switch-to-from-test)
(evil-leader/set-key-for-mode 'clojure-mode "r a r" 'cljr-add-require-to-ns)
(evil-leader/set-key-for-mode 'clojure-mode "r a i" 'cljr-add-import-to-ns)
(evil-leader/set-key-for-mode 'clojure-mode "r a p" 'cljr-add-project-dependency)
(evil-leader/set-key-for-mode 'clojure-mode "r a m" 'cljr-add-missing-libspec)
(evil-leader/set-key-for-mode 'clojure-mode "s i" 'cider-jack-in)
(evil-leader/set-key-for-mode 'clojure-mode "s s" 'cider-switch-to-repl-buffer)
(evil-leader/set-key-for-mode 'clojure-mode "s r" 'cider-restart)
(evil-leader/set-key-for-mode 'clojure-mode "s q" 'cider-quit)
(evil-leader/set-key-for-mode 'cider-repl-mode "s s" 'cider-switch-to-last-clojure-buffer)
(evil-leader/set-key-for-mode 'cider-repl-mode "s c" 'cider-repl-clear-buffer)
(evil-leader/set-key-for-mode 'cider-repl-mode "s r" 'cider-restart)
(evil-leader/set-key-for-mode 'cider-repl-mode "s q" 'cider-quit)
(evil-leader/set-key-for-mode 'clojure-mode "T p" 'cider-test-run-project-tests)
(evil-leader/set-key-for-mode 'clojure-mode "T n" 'cider-test-run-ns-tests)
(define-key clojure-mode-map (kbd "M-/") 'hippie-expand)

(setq cljr-suppress-middleware-warnings t
      +clojure/lein-profile-path "~/.lein/profiles.clj"
      +clojure/lein-plugins '(("refactor-nrepl" "2.4.1-SNAPSHOT")))

(defun +clojure/stringify-lein-plugin (plugin)
  (format "[%s \"%s\"]"
          (first plugin)
          (second plugin)))

(defun +clojure/create-lein-profile (path plugins)
  (with-temp-file path
    (let* ((base "{:user {:plugins [")
           (len (length base))
           (indent (make-string len ?\ )))
      (insert base)
      (insert (+clojure/stringify-lein-plugin (first plugins)))
      (mapcar (lambda (plugin)
                (insert (format "\n%s" indent))
                (insert (+clojure/stringify-lein-plugin plugin)))
              (cdr plugins))
      (insert "]}}\n"))))

(defun +clojure/generate-etags ()
  (interactive)
  (when-let ((root (projectile-project-root)))
    (let ((default-directory root))
      (shell-command (concat "find . -name '*.clj' | "
                             "xargs etags --language=lisp "
                             "--regex='/[ \\t\\(]*def[a-z]* \\([a-z-!]+\\)/\\1/' "
                             "--regex='/[ \\t\\(]*ns \\([a-z.]+\\)/\\1/'")))))

(when (not (file-exists-p +clojure/lein-profile-path))
  (+clojure/create-lein-profile +clojure/lein-profile-path
                         +clojure/lein-plugins))
