;;; Package init-anaconda-mode summary
;; Configureation of python IDE using anaconda-mode
(require-package 'anaconda-mode)
(require-package 'company-anaconda)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-anaconda))
(setq anaconda-mode-server-script "/usr/local/lib/python2.7/site-packages/anaconda_mode.py")
(setq python-shell-interpreter "ipython")

(provide 'init-anaconda-mode)
