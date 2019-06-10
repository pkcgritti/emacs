(require 'package)
(require 'cl)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'load-path "~/.emacs.d/elisp/")

(package-initialize)

(defvar e:dependencies
  '(company
    evil evil-leader
    key-chord
    linum-relative
    magit
    neotree
    paredit
    projectile
    rainbow-delimiters
    winum)
  "Emacs dependencies")

(load-library "e-utils")
(load-library "e-preferences")
(maybe-install-dependencies e:dependencies)

(load-library "e-packages-setup")
(load-library "e-hooks")
(load-library "e-keys")

(load-library "mode-clojure")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rainbow-delimiters key-chord linum-relative neotree evil-leader magit cider company evil paredit))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#242424" :foreground "#f6f3e8" :slant normal :weight normal :height 130 :width normal :foundry "PfEd" :family "Fira Code"))))
 '(company-preview ((t (:background "black" :foreground "white"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "color-33"))))
 '(company-scrollbar-bg ((((type x)) (:background "gray12")) (((type tty)) (:background "color-16"))))
 '(company-scrollbar-fg ((((type x)) (:background "royal blue")) (((type tty)) (:background "blue"))))
 '(company-tooltip ((((type x)) (:background "gray9" :foreground "white")) (((type tty)) (:background "brightblack" :foreground "white"))))
 '(company-tooltip-annotation ((t (:foreground "color-39"))))
 '(company-tooltip-common ((((type x)) (:foreground "royal blue")) (((type tty)) (:foreground "color-33"))))
 '(company-tooltip-selection ((t (:background "black")))))
