;;; LaTeX mode configurations
(use-package auctex
  :ensure t
  :hook ((reftex-load-hook . imenu-add-menubar-index)
         (reftex-mode-hook . imenu-add-menubar-index))
  :init
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-view-program-list
        '(("qpdfview"
           ("qpdfview --unique %o"
            (mode-io-correlate "#src:%b:%n:0"))
           "qpdfview")))
  (setq-default TeX-master nil))

(add-to-list 'TeX-view-program-selection
             '(output-pdf "qpdfview"))


