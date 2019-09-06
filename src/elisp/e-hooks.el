;; Emacs hooks

(add-hook 'after-init-hook 'global-company-mode)

(defun ++eshell/hook ()
  (when-let ((dir (projectile-project-root)))
    (insert (concat "cd " dir))
    (eshell-send-input)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input))))
(add-hook 'eshell-mode-hook '++eshell/hook)

(defun ++tide/hook ()
  (interactive)
  (tide-setup)
  (eldoc-mode +1)
  (company-mode +1))
(add-hook 'typescript-mode-hook #'++tide/hook)
