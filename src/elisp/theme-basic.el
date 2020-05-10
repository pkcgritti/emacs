;;; Basic emacs theme
;; (load-theme 'manoj-dark)
(load-theme 'leuven)

(when (window-system)
  (cond ((find-font (font-spec :name "Fira Code"))
         (set-frame-font "Fira Code"))
        ((find-font (font-spec :name "Ubuntu Mono"))
         (set-frame-font "Ubuntu Mono"))
        ((find-font (font-spec :name "Source Code Pro"))
         (set-frame-font "Source Code Pro"))))
