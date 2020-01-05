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

(defalias 'workon 'pyvenv-workon)

(setq +python/src-dir ""
      +python/test-dir "tests/"
      +python/test-prefix "test_"
      +python/test-suffix "")

(defun +python/src-to-test (root curr-file)
  "Returns the path for tests/*/file given `curr-file`"
  (let* ((base-name (file-name-base curr-file))
         (base-dir (file-name-directory curr-file))
         (test-name (concat +python/test-prefix base-name))
         (test-dir (concat +python/test-dir base-dir)))
    (concat root test-dir test-name ".py")))

(defun +python/test-to-src (root curr-file)
  "Returns the path for */file given `curr-file`"
  (let* ((base-name (file-name-base curr-file))
         (base-dir (file-name-directory curr-file))
         (src-name (replace-regexp-in-string +python/test-prefix "" base-name))
         (src-name (replace-regexp-in-string +python/test-suffix "" src-name))
         (src-dir (replace-regexp-in-string "tests/" "" base-dir)))
    (concat root src-dir src-name ".py")))

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

(defun +python/run-pytest (verbose)
  (interactive "P")
  (when-let (root (projectile-project-root))
    (let ((default-directory root))
      (if verbose (compile "pytest -vv")
        (compile "pytest")))))

(evil-leader/set-key-for-mode 'python-mode "f s" '+python/switch-to-from-test)
(evil-leader/set-key-for-mode 'python-mode "p t" '+python/run-pytest)
(evil-leader/set-key-for-mode 'python-mode "p w" 'workon)
