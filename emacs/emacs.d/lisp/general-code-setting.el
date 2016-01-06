;;; Package general-code-setting Summary

;;enable company mode globally and add company-anaconda backend
(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)

(provide 'general-code-setting)
