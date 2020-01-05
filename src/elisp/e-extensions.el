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
          (t (call-interactively #'neotree-enter)))))

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
  
(defun +neotree/open-and-hide ()
  "Enter file hiding neotree."
  (interactive)
  (call-interactively #'neotree-enter)
  (call-interactively #'neotree-toggle))

(setq +clj/src-dir "src/"
      +clj/test-dir "test/"
      +clj/test-prefix ""
      +clj/test-suffix "_test"
      +python/src-dir ""
      +python/test-dir "tests/"
      +python/test-prefix "test_"
      +python/test-suffix "")


(defun +clj/src-to-test (root curr-file)
  "Returns the path for test/*/file given `curr-file`"
  (let* ((base-name (file-name-base curr-file))
         (base-dir (file-name-directory curr-file))
         (test-name (concat +clj/test-prefix base-name +clj/test-suffix))
         (test-dir (replace-regexp-in-string "src/" "test/" base-dir)))
    (concat root test-dir test-name ".clj")))

(defun +clj/test-to-src (root base-name)
  "Returns the path for src/*/file given `curr-file`"
  (let* ((base-name (file-name-base curr-file))
         (base-dir (file-name-directory curr-file))
         (src-name (replace-regexp-in-string +clj/test-prefix "" base-name))
         (src-name (replace-regexp-in-string +clj/test-suffix "" src-name))
         (src-dir (replace-regexp-in-string "test/" "src/" base-dir)))
    (concat root src-dir src-name ".clj")))

(defun +clj/switch-to-from-test ()
  "Switch to/from matching test file. If test file does not
exists, ask if the user wants to create it."
  (interactive)
  (when-let (root (projectile-project-root))
    (let* ((file-name (buffer-file-name))
           (curr-file (replace-regexp-in-string root "" file-name))
           (curr-type (cond ((string-prefix-p "src/" curr-file) "src/")
                            ((string-prefix-p "test/" curr-file) "test/")
                            (t nil)))
           (target (pcase curr-type
                     ("src/" (+clj/src-to-test root curr-file))
                     ("test/" (+clj/test-to-src root curr-file))
                     ("invalid" nil))))
      (if target (find-file target)
        (message (concat "Cannot switch from " file-name))))))
    
(defun +python/src-to-test (root curr-file)
  "Returns the path for tests/*/file given `curr-file`"
  (let* ((base-name (file-name-base curr-file))
         (base-dir (file-name-directory curr-file))
         (test-name (concat +python/test-prefix base-name))
         (test-dir (concat +python/test-dir base-dir)))
    (concat root test-dir test-name ".py")))

(defun +python/test-to-src (root curr-file)
  "Returns the path for */file given `curr-file`"
  (let* ((base-name (file-name-base curr-file))
         (base-dir (file-name-directory curr-file))
         (src-name (replace-regexp-in-string +python/test-prefix "" base-name))
         (src-name (replace-regexp-in-string +python/test-suffix "" src-name))
         (src-dir (replace-regexp-in-string "tests/" "" base-dir)))
    (concat root src-dir src-name ".py")))

(defun +python/switch-to-from-test ()
  "Switch to/from matching test file. If test file does not
exists, ask if the user wants to create it."
  (interactive)
  (when-let (root (projectile-project-root))
    (let* ((file-name (buffer-file-name))
           (curr-file (replace-regexp-in-string root "" file-name))
           (curr-type (cond ((string-prefix-p "tests/" curr-file) "tests/")
                            (t "src")))
           (target (pcase curr-type
                     ("tests/" (+python/test-to-src root curr-file))
                     ("src" (+python/src-to-test root curr-file)))))
      (if target (find-file target)
        (message (concat "Cannot switch from " file-name))))))
