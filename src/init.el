(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these to lines to enable/disable MELPA and MELPA Stable
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (const "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; ====================================================================================================
;; ======================================= SCRIPT SECTION =============================================
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfile nil) ; completely disable emacs #files
(setq inhibit-startup-screen t)
(load-theme 'adwaita)

(defvar root-directory
  "/home/gritti"
  "The initial directory")

(defvar root-directory-file
  "/home/gritti/.last-emacs-root"
  "File to save the last used root dir")

(defun root-directory-load ()
  "Load last root directory"
  (if (file-exists-p root-directory-file)
      (setq root-directory (with-temp-buffer
	(insert-file-contents root-directory-file)
	(buffer-string)))
    nil))

(defun root-directory-save ()
  "Save last root directory"
  (with-temp-buffer
    (insert root-directory)
    (write-file root-directory-file)))

(defun open-next-line ()
  "Open next line"
  (interactive)
  (move-end-of-line 1)
  (newline))

(defun open-prev-line ()
  "Open prev line"
  (interactive)
  (move-end-of-line 0)
  (newline))

(root-directory-load)

;; General hotkeys
(global-set-key [C-return] 'open-next-line)
(global-set-key [C-S-return] 'open-prev-line)
 
;; Setup company mode
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-n") 'company-complete)

;; ====================================================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (flycheck company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
