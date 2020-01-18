;; Javascript/Typescript mode preferences
(defun +js/preferences ()
  (setq js-indent-level 2))

(add-hook 'js-mode-hook #'+js/preferences)

(defun +tide/hook ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'typescript-mode-hook #'+tide/preferences)
