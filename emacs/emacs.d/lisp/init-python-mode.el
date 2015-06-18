;; Configuration of Python IDE
(require 'elpy nil t)
(elpy-enable)
;; use jedi as default auto-complet
(setq elpy-rpc-backend "jedi")
;; use ipython as default python debugger
;; use C-c C-c to debug / run python script
(elpy-use-ipython)

(provide 'init-python-mode)
