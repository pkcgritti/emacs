;; Clojure specific settings

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'yas-minor-mode)
;; (add-hook 'clojure-mode-hook #'e:configure-clojure-keys)

(defun e:cider-kill-buffer ()
  (interactive))

(defun e:configure-clojure-keys ()
  (interactive)
  (evil-leader/set-key-for-mode clojure-mode-map "s i" 'cider-jack-in)
  (evil-leader/set-key-for-mode clojure-mode-map "s q" 'e:cider-kill-buffer))
