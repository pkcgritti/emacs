;; Eshell preferences
(defun +eshell/preferences ()
  (evil-emacs-state 1))

(add-hook 'eshell-mode-hook '+eshell/preferences)
