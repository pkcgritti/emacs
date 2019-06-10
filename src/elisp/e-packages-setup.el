;; Emacs packages setup

; Section -- Winum mode
(require 'winum)
(winum-mode)
(setq winum-format " W[%s] ")

; Section -- Evil mode
(require 'evil)
(require 'key-chord)
(evil-mode 1)
(setq key-chord-two-keys-delay 0.1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)

; Section -- Neotree
(require 'neotree)

; Section -- Linum-relative
(setq linum-relative-current-symbol "")
