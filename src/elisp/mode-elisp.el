;; Elisp specific settings
(defun +emacs-lisp/preferences ()
  (linum-mode 1)
  (linum-relative-mode 1)
  (paredit-mode 1)
  (rainbow-delimiters-mode 1))

(add-hook 'emacs-lisp-mode-hook '+emacs-lisp/preferences)
(add-hook 'lisp-interaction-mode-hook '+emacs-lisp/preferences)
