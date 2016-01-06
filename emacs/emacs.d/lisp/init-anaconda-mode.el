;;; Package init-anaconda-mode summary
;; Configureation of python IDE using anaconda-mode
(require-package 'anaconda-mode)
(require-package 'company-anaconda)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-anaconda))

(setq python-shell-interpreter "ipython")

(provide 'init-anaconda-mode)
