;; Python specific settings
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  (evil-leader/set-key "g d" 'elpy-goto-definition)
  (defun elpy-library-root ()
    (projectile-project-root)))

(use-package py-autopep8
  :ensure t
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

(use-package py-isort
  :ensure t
  :init
  (add-hook 'before-save-hook 'py-isort-before-save))

(defalias 'workon 'pyvenv-workon)
