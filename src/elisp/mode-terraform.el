;; Terraform mode configurations
(use-package terraform-mode
  :ensure t)

(use-package company-terraform
  :ensure t
  :init (company-terraform-init))
