(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
;;(eval-after-load "pymacs"                                                                                                                                                                               
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))                                                                                                                                              

;; ropemacs                                                                                                                                                                                               
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(defun load-ropemacs ()
   "Load pymacs and ropemacs"
   (interactive)
   (setenv "PYMACS_PYTHON" "python2.7")
   (require 'pymacs)
   (autoload 'pymacs-load "pymacs" nil t)
   (autoload 'pymacs-eval "pymacs" nil t)
   (autoload 'pymacs-apply "pymacs")
   (autoload 'pymacs-call "pymacs")
   (autoload 'pymacs-exec "pymacs" nil t)
   (pymacs-load "ropemacs" "rope-")
   (global-set-key [(meta ?/)] 'rope-code-assist)
   (setq rope-confirm-saving 'nil)
   )

(add-hook 'python-mode-hook 'load-ropemacs)

;pycomplete                                                                                                                                                                                               
(require   'pycomplete)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist(cons '("python" . python-mode)
                             interpreter-mode-alist))
