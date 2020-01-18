;; Bash specific settings
(setq +bash/execute-current-file--buffer
      "*bash-output*")

(defun +bash/execute-current-file ()
  (interactive)
  (when-let (root (projectile-project-root))
    (let* ((file-path (->> (buffer-file-name)
                           (replace-regexp-in-string root "")))
           (command file-path)
           (default-directory root)
           (temp-buff-name +bash/execute-current-file--buffer))
      (compile command))))

(defun +bash/preferences ()
  (linum-mode 1)
  (linum-relative-mode 1)
  (hl-line-mode -1)
  (local-set-key (kbd "<f5>") '+bash/execute-current-file))

(add-hook 'sh-mode-hook '+bash/preferences)
