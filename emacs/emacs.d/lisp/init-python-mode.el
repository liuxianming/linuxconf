;;; package init-python-mode Summary
;; Configuration of Python IDE
(require-package 'elpy)
(elpy-enable)
;; define yas-expand
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; define iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

(setq
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(provide 'init-python-mode)
;;; init-python-mode ends here
