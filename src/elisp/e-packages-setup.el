;; Emacs packages setup

;; Evil mode
(require 'evil)
(require 'key-chord)
(evil-mode 1)
(setq key-chord-two-keys-delay 0.1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)

;; Neotree
(require 'neotree)
(setq neo-autorefresh nil
      neo-auto-indent-point t)
(add-hook 'neotree-mode-hook '+global/no-linum)

;; Linum-relative
(setq linum-relative-current-symbol "")

;; Powerline
(require 'powerline)
(powerline-center-evil-theme)

;; Winum mode
(defun +winum/propertize (string)
  (put-text-property 0 (length string)
                     'font-lock-face  '(:foreground nil)
                     string)
  string)

(defvar winum--mode-line-segment
  '(:eval
    (+winum/propertize
     (+winum/get-symbol-char (winum-get-number)))))

(setq dingbat-circled-sans #x2781
      dingbat-negative-circled #x2777
      dingbat-negative-circled-sans #x2789)

(setq +winum/start-symbol dingbat-negative-circled-sans 
      +winum/format "  %c ")

(defun +winum/get-symbol-char (number)
    (format +winum/format (+ +winum/start-symbol number)))

(use-package winum
  :ensure t
  :init
  (winum-mode))

;; Helm
(require 'helm)
(require 'helm-projectile)
(helm-mode)

;; Paredit mode
(require 'paredit)
(paredit-mode)

;; Projectile
(require 'projectile)
(projectile-mode +1)
(setq projectile-mode-line ""
      projectile-mode-line-prefix " p"
      projectile-completion-system 'helm
      projectile-indexing-method 'alien)
(helm-projectile-on)

;; Yasnippets
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

;; Company
(require 'company)

;; Cider
(require 'cider)
(defun +cider/current-conn ()
  "Get current cider connection"
  (if (cider-connected-p)
      (let* ((bufname (buffer-name (cider-current-repl-buffer)))
	     (name (string-join (cdr (split-string bufname ":")) ":"))
	     (prefix "*cider-repl clojure/")
	     (suffix "(clj)*"))
	(s-chop-prefix prefix (s-chop-suffix suffix name)))
    "-"))
(setq cider-mode-line '(:eval (format "cider[%s]" (+cider/current-conn))))
(add-hook 'cider-repl-mode '+global/no-linum)
 
;; Diminish
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

;; Evil multiple cursors
(require 'evil-mc)
(global-evil-mc-mode 1)

;; Describe bindings
(require 'helm-descbinds)
(helm-descbinds-mode)

;; Which key - Show binding hints
(require 'which-key)
(which-key-mode)
