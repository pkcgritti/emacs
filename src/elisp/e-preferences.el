;; Emacs preferences

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)

(load-theme 'tango-dark)

(setq
 backup-by-copying t     ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))  ; don't litter my fs
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 eshell-buffer-name "*eshell*")

(advice-add 'eshell-life-is-too-much :after 'e:delete-current-window)
