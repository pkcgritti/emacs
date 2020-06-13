;; Emacs keys
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key '[f9] 'neotree-refresh)

(evil-define-key 'normal neotree-mode-map (kbd "G") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "h") '+neotree/collapse-or-up)
(evil-define-key 'normal neotree-mode-map (kbd "j") '+neotree/next-line)
(evil-define-key 'normal neotree-mode-map (kbd "J") '+neotree/next-sibling)
(evil-define-key 'normal neotree-mode-map (kbd "k") '+neotree/previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "K") '+neotree/previous-sibling)
(evil-define-key 'normal neotree-mode-map (kbd "l") '+neotree/expand-or-open)
(evil-define-key 'normal neotree-mode-map (kbd "L") 'neotree-enter-horizontal-split)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "s") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "o") '+neotree/open-and-hide)
(evil-define-key 'normal neotree-mode-map (kbd "O") 'neotree-enter-vertical-split)
;; For specific mode use: (evil-define-key 'insert mode-map key

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key evil-visual-state-map (kbd "C-d") 'mc/mark-next-like-this)
(define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd ")") 'evil-next-close-paren)
(define-key evil-normal-state-map (kbd "(") 'evil-previous-open-paren)
(define-key evil-normal-state-map (kbd "K") 'backward-paragraph)
(define-key evil-normal-state-map (kbd "J") 'forward-paragraph)
(define-key evil-visual-state-map (kbd ")") 'evil-next-close-paren)
(define-key evil-visual-state-map (kbd "(") 'evil-previous-open-paren)
(define-key evil-visual-state-map (kbd "K") 'backward-paragraph)
(define-key evil-visual-state-map (kbd "J") 'forward-paragraph)
(define-key evil-normal-state-map (kbd "z n") 'evil-open-folds)

;; Helm
(define-key helm-map (kbd "C-k") 'helm-previous-line)
(define-key helm-map (kbd "C-j") 'helm-next-line)

;; Company-mode
(define-key company-active-map (kbd "C-k") 'company-select-previous)
(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "TAB") 'company-complete-selection)

;; Leaders keys
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "'" '+emacs/focus-eshell)
(evil-leader/set-key "0" 'delete-window)
(evil-leader/set-key "1" 'winum-select-window-1)
(evil-leader/set-key "2" 'winum-select-window-2)
(evil-leader/set-key "3" 'winum-select-window-3)
(evil-leader/set-key "4" 'winum-select-window-4)
(evil-leader/set-key "5" 'winum-select-window-5)
(evil-leader/set-key "6" 'winum-select-window-6)
(evil-leader/set-key "b b" 'switch-to-buffer)
(evil-leader/set-key "b k" '+emacs/kill-current-buffer)
(evil-leader/set-key "e e" 'eval-last-sexp)
(evil-leader/set-key "f e D" 'open-elisp-dir)
(evil-leader/set-key "f e d" 'open-emacs-file)
(evil-leader/set-key "f e r" '+emacs/reload-emacs-file)
(evil-leader/set-key "f f" '+emacs/neotree-focus)
(evil-leader/set-key "f t" '+emacs/neotree-toggle)
(evil-leader/set-key "l I" 'indent-region)
(evil-leader/set-key "l i" 'indent-for-tab-command)
(evil-leader/set-key "l j" 'evil-join)
(evil-leader/set-key "p f" 'projectile-find-file)
(evil-leader/set-key "p s" 'projectile-switch-project)

(evil-leader/set-key "t n" 'linum-mode)
(evil-leader/set-key "t p" 'paredit-mode)
(evil-leader/set-key "t r" 'linum-relative-mode)
(evil-leader/set-key "t h" 'hl-line-mode)
(evil-leader/set-key "t e p" 'electric-pair-mode)

(evil-leader/set-key "w -" 'delete-other-windows)
(evil-leader/set-key "w 1" 'delete-other-windows)
(evil-leader/set-key "w 2" 'split-window-below)
(evil-leader/set-key "w 3" 'split-window-right)
(evil-leader/set-key "w h" 'evil-window-left)
(evil-leader/set-key "w j" 'evil-window-down)
(evil-leader/set-key "w k" 'evil-window-up)
(evil-leader/set-key "w l" 'evil-window-right)
(evil-leader/set-key "w o" 'other-window)
(evil-leader/set-key "w w" 'other-window)

(evil-leader/set-key "x a" 'xref-find-apropos)
(evil-leader/set-key "x r" 'xref-find-references)

(evil-leader/set-key "z s" 'set-font-height)
(evil-leader/set-key "z +" 'increase-font-height)
(evil-leader/set-key "z =" 'increase-font-height)
(evil-leader/set-key "z -" 'decrease-font-height)


;; Fast commands helper
(defvar +emacs/fast-command
  nil
  "A fast command to execute with <f8> keybinding.")

(defun +emacs/eval-defun ()
  (eval-defun nil))

(defun +emacs/exec-fast-command ()
  (interactive)
  (when-let (command +emacs/fast-command)
    (funcall command)))

(defun +emacs/set-fast-command ()
  (interactive)
  (setq +emacs/fast-command
        (+emacs/eval-defun)))

(global-set-key (kbd "<f8>") '+emacs/exec-fast-command)
(global-set-key (kbd "<f9>") '+emacs/set-fast-command)
(global-set-key (kbd "M-n") 'company-complete)

