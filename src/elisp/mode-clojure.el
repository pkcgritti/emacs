;; Clojure specific settings
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'yas-minor-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

(defun e:cider-kill-server ()
  "Kill cider server"
  (interactive))

(evil-leader/set-key-for-mode 'clojure-mode "s i" 'cider-jack-in)
(evil-leader/set-key-for-mode 'clojure-mode "s r" 'cider-refresh)
(evil-leader/set-key-for-mode 'clojure-mode "s q" 'cider-quit)
(evil-leader/set-key-for-mode 'clojure-mode "r a r" 'cljr-add-require-to-ns)
(evil-leader/set-key-for-mode 'clojure-mode "r a i" 'cljr-add-import-to-ns)
(evil-leader/set-key-for-mode 'clojure-mode "r a p" 'cljr-add-project-dependency)
(define-key clojure-mode-map (kbd "M-/") 'hippie-expand)

(evil-leader/set-key-for-mode 'cider-mode "s r" 'cider-refresh)
(evil-leader/set-key-for-mode 'cider-mode "s q" 'cider-quit)

;; TODO: Check if filepath does not change on windows.
;; (setq e:lein-profile-path "~/.lein/profiles.clj")

;; (defun e:configure-repl-profile ()
;;   (interactive)
;;   (if (not (file-exists-p e:lein-profile-path))
;;       (with-temp-file e:lein-profile-path
;; 	(insert ":plugins [[refactor-nrepl       \"2.5.0-SNAPSHOT\"]
;;           [cider/cider-nrepl    \"0.22.0-beta5\"]]\n"))))
;; (e:configure-repl-profile)
	
(defun e:configure-cider-plugins ()
  "Configure cider variables"
  (setq cider-jack-in-lein-plugins
	'(("refactor-nrepl" "2.4.1-SNAPSHOT" :predicate cljr--inject-middleware-p)
	  ("cider/cider-nrepl" "0.22.0-beta1"))))
(e:configure-cider-plugins)
(add-hook 'clojure-mode-hook 'e:configure-cider-plugins t)
(add-hook 'cider-mode-hook 'e:configure-cider-plugins t)
