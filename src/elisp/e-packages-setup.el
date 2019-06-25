;; Emacs packages setup

;; Section -- Winum mode
(require 'winum)
(winum-mode)
(setq winum-format " W[%s] ")

;; Section -- Evil mode
(require 'evil)
(require 'key-chord)
(evil-mode 1)
(setq key-chord-two-keys-delay 0.1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)

;; Section -- Neotree
(require 'neotree)
(setq neo-autorefresh nil)

;; Section -- Linum-relative
(setq linum-relative-current-symbol "")

;; Section -- Powerline
(require 'powerline)
(powerline-center-evil-theme)

;; Section -- Helm
(require 'helm)
(require 'helm-projectile)
(helm-mode)

;; Section -- Paredit mode
(require 'paredit)
(paredit-mode)

;; Section -- Projectile
(require 'projectile)
(projectile-mode +1)
(setq projectile-mode-line ""
      projectile-mode-line-prefix " p"
      projectile-completion-system 'helm
      projectile-indexing-method 'alien)
(helm-projectile-on)

;; Section -- Yasnippets
(require 'yasnippet)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
	try-complete-file-name-partially
	try-expand-all-abbrevs
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

;; Section -- Company
(require 'company)

;; Section -- Cider
(require 'cider)
(defun e:cider-current-conn ()
  "Get current cider connection"
  (if (cider-connected-p)
      (let* ((bufname (buffer-name (cider-current-repl-buffer)))
	     (name (string-join (cdr (split-string bufname ":")) ":"))
	     (prefix "*cider-repl clojure/")
	     (suffix "(clj)*"))
	(s-chop-prefix prefix (s-chop-suffix suffix name)))
    "-"))
(setq cider-mode-line '(:eval (format "cider[%s]" (e:cider-current-conn))))
 
;; Section -- Diminish
(require 'diminish)
(eval-after-load "filladapt" '(diminish 'filladapt-mode))
(diminish 'company-mode)
(diminish 'undo-tree-mode)
(diminish 'helm-mode)
(diminish 'paredit-mode "pedit")
(diminish 'eldoc-mode "eldoc")
(diminish 'projectile-mode)

;; Magit setup
(require 'magit)
(setq evil-magit-state 'normal)
(require 'evil-magit)

;; Section -- Evil multiple cursors
(require 'evil-mc)
(global-evil-mc-mode 1)
