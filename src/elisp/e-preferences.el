;; Emacs preferences
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)

(setq-default indent-tabs-mode nil)
(setq inhibit-startup-screen t
      backup-by-copying t ;; don't clobber symlinks
      backup-directory-alist '(("." . "~/.saves/")) ;; don't litter my fs
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      compilation-scroll-output t
      eshell-buffer-name "*eshell*")

(advice-add 'eshell-life-is-too-much :after '+emacs/delete-current-window)

;; TODO: Check if its ok to add eldoc as global
(global-eldoc-mode)

(setq +file/separator "/")

(defun +file/split-paths (filename)
  (split-string filename +file/separator))

(defun +file/root-name (filename)
  (-> (+file/split-paths filename)
      butlast last car))

(defun +emacs/get-window-name ()
  (if-let (root (projectile-project-root))
      (concat "<" (+file/root-name root) "> "
              "%b")
    "%b [%m]"))

(setq-default frame-title-format
              '(:eval (+emacs/get-window-name)))
