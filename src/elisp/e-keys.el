;; Emacs keys
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "j") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "k") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "l") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "L") 'neotree-enter-horizontal-split)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "s") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "o") 'neotree-enter-ace-window)

(define-key evil-normal-state-map (kbd "<SPC>") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "<SPC>") 'evil-end-of-line)
; For specific mode use: (evil-define-key 'insert mode-map key def)

(evil-leader/set-leader ",")
(evil-leader/set-key "t r" 'linum-relative-mode)
(evil-leader/set-key "t f" 'e:neotree-toggle)
(evil-leader/set-key "f e d" 'open-emacs-file)
(evil-leader/set-key "f e D" 'open-elisp-dir)
(evil-leader/set-key "f f" 'e:neotree-focus)
(evil-leader/set-key "e e" 'eval-last-sexp)
(evil-leader/set-key "w 1" 'winum-select-window-1)
(evil-leader/set-key "w 2" 'winum-select-window-2)
(evil-leader/set-key "w 3" 'winum-select-window-3)
(evil-leader/set-key "w 4" 'winum-select-window-4)
(evil-leader/set-key "w 5" 'winum-select-window-5)
(evil-leader/set-key "w 6" 'winum-select-window-6)
(evil-leader/set-key "w h" 'evil-window-left)
(evil-leader/set-key "w k" 'evil-window-up)
(evil-leader/set-key "w j" 'evil-window-down)
(evil-leader/set-key "w l" 'evil-window-right)
(evil-leader/set-key "w -" 'delete-other-windows)
(evil-leader/set-key "w o" 'other-window)
(evil-leader/set-key "t n" 'linum-mode)
