;; Clojure specific settings

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(evil-leader/set-key-for-mode 'clojure-mode "s i" 'cider-jack-in)
(evil-leader/set-key-for-mode 'clojure-mode "e f" 'cider-eval-file)
(evil-leader/set-key-for-mode 'clojure-mode "e e" 'cider-eval-last-sexp)
