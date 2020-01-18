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

(defun open-elisp-dir ()
  "Navigate to .emacs.d/elisp directory"
  (interactive)
  (find-file "~/.emacs.d/elisp/"))

(defun +emacs/neotree-toggle ()
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

(defun +emacs/neotree-focus ()
  "Focus neotree"
  (interactive)
  (if (neo-global--window-exists-p)
      (neotree-show)
    (+emacs/neotree-toggle)))

(defun eshell-get-buffer-create (&optional arg)
  "Create an interactive eshell buffer. Return the eshell buffer, creating
it if needed. The buffer used for eshell sessions is determined by the value
of `eshell-buffer-name'. A numeric prefix arg (as in `C-u 42 M-x eshell RET')
switches to the session with that number, creating it if necessary. A nonnumeric
prefix arg means to create a new session. Returns the buffer selected/created."
  (interactive "P")
  (cl-assert eshell-buffer-name)
  (let ((buf (cond ((numberp arg)
		    (get-buffer-create (format "%s<%d>"
					       eshell-buffer-name
					       arg)))
		   (arg
		    (generate-new-buffer eshell-buffer-name))
		   (t
		    (get-buffer-create eshell-buffer-name)))))
    (cl-assert (and buf (buffer-live-p buf)))
    (with-current-buffer buf
      (unless (derived-mode-p 'eshell-mode)
	(eshell-mode)))
    buf))

(defun +emacs/get-bottom-window ()
  (let ((w (car (window-edges)))
        (h (- (frame-height) 3)))
    (window-at w h)))

(defun +emacs/assert-bottom-buffer ()
  (let ((bw (+emacs/get-bottom-window)))
    (when (not (equal (selected-window) bw))
      (switch-to-buffer-other-window (window-buffer bw)))))

(defun +emacs/kill-current-buffer ()
  (kill-buffer (current-buffer)))

(defun +emacs/focus-eshell (&optional arg)
  "Focus eshell on bottom window"
  (interactive "P")
  (let ((buf (eshell-get-buffer-create)))
    (if (get-buffer-window buf)
        (switch-to-buffer-other-window buf)
      (progn (+emacs/assert-bottom-buffer)
             (window--display-buffer
              buf (split-window (selected-window) nil 'below)
              'window `((window-height . 15 )) display-buffer-mark-dedicated)
             (switch-to-buffer-other-frame buf)))))

(defun +emacs/delete-current-window ()
  (when (not (one-window-p))
    (delete-window)))

(defun +emacs/reload-emacs-file ()
  (interactive)
  (load-file "~/.emacs"))
