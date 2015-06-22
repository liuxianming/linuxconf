;;; package init-python-mode Summary
;; Configuration of Python IDE
;; to enable jedi, need to:
;; M-x package-install RET jedi RET
;; M-x jedi:install-server
(require-package 'elpy)

(require 'elpy nil t)
;;; Code:
(elpy-enable)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; use jedi as default auto-complet
(setq elpy-rpc-backend "jedi")
;; use ipython as default python debugger
;; use C-c C-c to debug / run python script
(elpy-use-ipython)

(provide 'init-python-mode)
;;; init-python-mode ends here
