;;; package init-python-mode Summary
;; Configuration of Python IDE
(require-package 'elpy)
(elpy-enable)
;; define yas-expand
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; define iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

(provide 'init-python-mode)
;;; init-python-mode ends here
