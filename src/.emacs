(require 'package)
(require 'cl)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'load-path "~/.emacs.d/elisp/")

(package-initialize)

(defvar e:dependencies
  '(cider
    clj-refactor
    clojure-snippets
    company
    diminish
    evil
    evil-leader
    evil-magit
    evil-mc
    helm 
    helm-descbinds
    helm-projectile
    key-chord
    linum-relative
    magit
    markdown-mode
    neotree
    paredit
    powerline
    projectile
    rainbow-delimiters
    tide
    use-package
    which-key
    winum
    yasnippet)
  "Emacs dependencies")
(load-library "e-utils")
(load-library "e-preferences")
(maybe-install-dependencies e:dependencies)

(load-library "e-packages-setup")
(load-library "e-extensions")
(load-library "e-hooks")
(load-library "e-keys")

(load-library "mode-clojure")
(load-library "mode-elisp")
(load-library "mode-groovy")
(load-library "mode-python")
(load-library "mode-typescript")

(when (window-system)
  (cond ((find-font (font-spec :name "Ubuntu Mono"))
         (set-frame-font "Ubuntu Mono"))
        ((find-font (font-spec :name "Fira Code"))
         (set-frame-font "Fira Code"))
        ((find-font (font-spec :name "Source Code Pro"))
         (set-frame-font "Source Code Pro"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (groovy-mode python-docstring-mode python-docstring sphinx-doc elpy tide 0blayout markdown-mode helm-projectile diminish cyphejor clj-refactor powerline rainbow-delimiters key-chord linum-relative neotree evil-leader magit cider company evil paredit)))
 '(rainbow-delimiters-max-face-count 6))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#272727" :foreground "#eeeeee" :height 140))))
 '(clojure-keyword-face ((t (:inherit font-lock-builtin-face))))
 '(company-preview ((t (:background "black" :foreground "white"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "#0087ff"))))
 '(company-scrollbar-bg ((t (:background "#1f1f1f"))))
 '(company-scrollbar-fg ((t (:background "#4169e1"))))
 '(company-tooltip ((t (:background "#171717" :foreground "white"))))
 '(company-tooltip-annotation ((t (:foreground "00afff"))))
 '(company-tooltip-common ((t (:foreground "#4169e1"))))
 '(company-tooltip-selection ((t (:background "black"))))
 '(cursor ((t (:background "#fa8072"))))
 '(font-lock-comment-face ((t (:foreground "#73d216"))))
 '(font-lock-keyword-face ((t (:foreground "#9370db"))))
 '(font-lock-string-face ((t (:foreground "#ff8700"))))
 '(helm-command ((t (:background "black"))))
 '(helm-header ((t (:background "#222" :foreground "#fff" :height 1.0))))
 '(helm-selection ((t (:background "#696969"))))
 '(helm-source-header ((t (:background "#483d8b" :foreground "white" :weight ultra-bold :height 1.3))))
 '(hl-line ((t (:inherit nil :foreground nil :background "#111111"))))
 '(mode-line ((t (:foreground "#333333"))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "#666666" :style released-button)))))
 '(powerline-active1 ((t (:inherit mode-line :background "#383838" :foreground "white"))))
 '(powerline-active2 ((t (:inherit mode-line :background "#666666"))))
 '(show-paren-match ((t (:background "#555")))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
