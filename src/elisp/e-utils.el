;; Global emacs settings

(defun has-missing-dependencies-p (deps)
  "Check if emacs has missing dependencies."
  (seq-some (lambda (package)
	      (not (package-installed-p package)))
	    deps))

(defun install-dependencies (deps)
  "Install emacs dependencies"
  (package-refresh-contents)
  (seq-doseq (package deps)
    (if (not (package-installed-p package))
	(package-install package))))

(defun maybe-install-dependencies (deps)
  "Install dependencies if it needs to."
  (if (has-missing-dependencies-p deps) (install-dependencies deps)))

(defun open-emacs-file ()
  "Navigate to .emacs file"
  (interactive)
  (find-file "~/.emacs"))

(defun e:neotree-toggle ()
  "Open neotree using the project root, using projectile or the current buffer directory"
  (interactive)
  (let ((project-dir (ignore-errors (projectile-project-root)))
	(file-name (buffer-file-name))
	(neo-smart-open t))
    (if (neo-global--window-exists-p)
	(neotree-hide)
      (progn
	(neotree-show)
	(if project-dir
	    (neotree-dir project-dir))
	(if file-name
	    (neotree-find file-name))))))

(defun e:neotree-focus ()
  "Focus neotree"
  (interactive)
  (if (neo-global--window-exists-p)
      (neotree-show)
    (e:neotree-toggle)))
