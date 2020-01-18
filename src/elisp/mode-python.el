;; Python specific settings
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  (evil-leader/set-key "g d" 'elpy-goto-definition)
  (defun elpy-library-root ()
    (projectile-project-root))
  (setq elpy-test-pytest-runner-command '("py.test")
        elpy-test-runner 'elpy-test-pytest-runner))

(use-package pip-requirements
  :ensure t)

(use-package py-autopep8
  :ensure t
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

(use-package py-isort
  :ensure t
  :init
  (add-hook 'before-save-hook 'py-isort-before-save))

(use-package sphinx-doc
  :ensure t
  :init
  (add-hook 'python-mode-hook 'sphinx-doc-mode))

(use-package python-docstring
  :ensure t
  :init
  (add-hook 'python-mode-hook 'python-docstring-mode))

(defalias 'workon 'pyvenv-workon)

(setq +python/execute-current-file--buffer
      "*python-output*")

(defun +python/execute-current-file ()
  (interactive)
  (when-let (root (projectile-project-root))
    (let* ((file-path (->> (buffer-file-name)
                           (replace-regexp-in-string root "")))
           (command (concat "python " file-path))
           (default-directory root)
           (temp-buff-name +python/execute-current-file--buffer))
      (compile command))))

(defun +python/execute-current-file--deprecated ()
  (interactive)
  (when-let (root (projectile-project-root))
    (let* ((file-path (->> (buffer-file-name)
                           (replace-regexp-in-string root "")))
           (command (concat "python " file-path))
           (default-directory root)
           (temp-buff-name +python/execute-current-file--buffer))
      (get-buffer-create temp-buff-name)
      (switch-to-buffer-other-window temp-buff-name)
      (with-output-to-temp-buffer temp-buff-name
          (let ((message-log-max nil))
            (insert (shell-command-to-string command))))
      (special-mode)
      (evil-emacs-state 1))))

(defun +python/preferences ()
  (linum-mode 1)
  (linum-relative-mode 1)
  (hl-line-mode -1)
  (local-set-key (kbd "<f5>") '+python/execute-current-file)
  (local-set-key (kbd "<f6>") '+python/execute-current-file))

(add-hook 'python-mode-hook '+python/preferences)

(defun +python/src-in-project-p ()
  (interactive)
  (if-let ((root (projectile-project-root)))
      (if (file-directory-p (concat root "src"))
          "src/" "") ""))

(defun +python/get-module-path (relpath)
  (->> relpath 
       (file-name-directory)
       (replace-regexp-in-string "^\\(src\\|tests\\)/" "")))

(defun +python/src-module-path (relpath)
  (->> relpath
       (+python/get-module-path)
       (concat (+python/src-in-project-p))))

(defun +python/tests-module-path (relpath)
  (->> relpath
       (+python/get-module-path)
       (concat "tests/")))

(defun +python/get-module-file (relpath)
  (->> relpath
       (file-name-nondirectory)
       (replace-regexp-in-string "^test_" "")))

(defun +python/src-module-file (relpath)
  (+python/get-module-file relpath))

(defun +python/tests-module-file (relpath)
  (concat "test_" (+python/get-module-file relpath)))

(defun +python/src-to-test (root curr-file)
  (concat root
          (+python/tests-module-path curr-file)
          (+python/tests-module-file curr-file)))

(defun +python/test-to-src (root curr-file)
  "Returns the path for */file given `curr-file`"
  (concat root
          (+python/src-module-path curr-file)
          (+python/src-module-file curr-file)))

(defun +python/switch-to-from-test ()
  "Switch to/from matching test file. If test file does not
exists, ask if the user wants to create it."
  (interactive)
  (when-let (root (projectile-project-root))
    (let* ((file-name (buffer-file-name))
           (curr-file (replace-regexp-in-string root "" file-name))
           (curr-type (cond ((string-prefix-p "tests/" curr-file) "tests/")
                            (t "src")))
           (target (pcase curr-type
                     ("tests/" (+python/test-to-src root curr-file))
                     ("src" (+python/src-to-test root curr-file)))))
      (if target (find-file target)
        (message (concat "Cannot switch from " file-name))))))

(defun +emacs/compile-on-root (command)
  (interactive "sCommand: ")
  (when-let (root (projectile-project-root))
    (let ((default-directory root))
      (compile command))))

(defun +python/run-pytest (verbose)
  (interactive "P")
  (if verbose (+emacs/compile-on-root "pytest -vv")
    (+emacs/compile-on-root "pytest")))

(defun +python/run-pytest-cov (target)
  (interactive "sTarget: ")
  (+emacs/compile-on-root (concat "pytest --cov=" target)))

(defun +python/compile-docs ()
  (interactive)
  (+emacs/compile-on-root "make -C docs html"))

(defun +python/start-jupyter ()
  (interactive)
  (when-let (root (projectile-project-root))
    (let ((default-directory root))
      (start-process-shell-command
       "jupyter-name"
       "*jupyter*"
       "jupyter notebook"))))

(defun +python/kill-jupyter ()
  (interactive)
  (when-let (buffer (get-buffer "*jupyter*"))
    (kill-buffer buffer)))

(evil-leader/set-key-for-mode 'python-mode "f s" '+python/switch-to-from-test)
(evil-leader/set-key-for-mode 'python-mode "p t" '+python/run-pytest)
(evil-leader/set-key-for-mode 'python-mode "p w" 'workon)
(evil-leader/set-key-for-mode 'python-mode "p c d" '+python/compile-docs)
(evil-leader/set-key-for-mode 'python-mode "p c c" '+python/run-pytest-cov)
(evil-leader/set-key-for-mode 'python-mode "p j s" '+python/start-jupyter)
(evil-leader/set-key-for-mode 'python-mode "p j k" '+python/kill-jupyter)
