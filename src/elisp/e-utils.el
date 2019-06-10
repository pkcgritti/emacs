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

