;; Custom extensions
(defun +global/no-linum ()
  (linum-mode -1))

(defun +neotree/collapse-or-up ()
  "Collapse an expanded directory node or go to the parent node."
  (interactive)
  (when-let* ((node (neo-buffer--get-filename-current-line)))
    (if (file-directory-p node)
        (if (neo-buffer--expanded-node-p node)
            (+neotree/collapse)
          (neotree-select-up-node))
      (neotree-select-up-node))))

(defun +neotree/collapse ()
  "Collapse current node."
  (interactive)
  (when-let* ((node (neo-buffer--get-filename-current-line)))
    (when (file-directory-p node)
      (neo-buffer--set-expand node nil)
      (neo-buffer--refresh t))
    (when neo-auto-indent-point
      (neo-point-auto-indent))))

(defun +neotree/expand-or-open ()
  "Expand or open a neotree node."
  (interactive)
  (when-let* ((node (neo-buffer--get-filename-current-line)))
    (cond ((file-directory-p node)
           (neo-buffer--set-expand node t)
           (neo-buffer--refresh t)
           (when neo-auto-indent-point
             (forward-line)
             (neo-point-auto-indent)))
          (t (call-interactively #'neotree-enter)
             (call-interactively #'neotree-toggle)))))

(defun +neotree/next-line ()
  "Move to next line and indent."
  (interactive)
  (neotree-next-line)
  (when neo-auto-indent-point
    (neo-point-auto-indent)))

(defun +neotree/previous-line ()
  "Move the previous line and indent."
  (interactive)
  (neotree-previous-line)
  (when neo-auto-indent-point
    (neo-point-auto-indent)))

(defun +neotree/next-sibling ()
  "Move to next sibling with cycle enabled."
  (interactive)
  (neotree-select-next-sibling-node))

(defun +neotree/previous-sibling ()
  "Move to previous sibling with cycle enabled."
  (interactive)
  (neotree-select-previous-sibling-node))
  
