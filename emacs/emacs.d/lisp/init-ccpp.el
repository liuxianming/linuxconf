;;; Package init-ccpp summary
;; configuration for c/c++

;; auto-compelete
; start auto-complete with emacs
(require-package 'auto-complete)
(require-package 'cuda-mode)
(require-package 'yasnippet)
(require-package 'google-c-style)
(require-package 'auto-complete-c-headers)
(require-package 'flymake-google-cpplint)

(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)
; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; for mac platform, using 
  ;; gcc -xc++ -E -v -
  ;; to find the xcode include folder
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include")
  ; for linux workstation, use:
  (add-to-list 'achead:include-directories '"/opt/intel/composer_xe_2015.0.090/ipp/include")
  (add-to-list 'achead:include-directories '"/opt/intel/composer_xe_2015.0.090/mkl/include")
  (add-to-list 'achead:include-directories '"/opt/intel/composer_xe_2015.0.090/tbb/include")
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include")
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/include")
)
;; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

; start flymake-google-cpplint-load
; let's define a function for flymake initialization
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   ;; cpplint: install using pip install cpplint, and it should be installed to /usr/local/bin/cpplint
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load))
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete ()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

(defconst cedet-user-include-dirs
  (list
   ".."
   "../include"
   "../inc"
   "../common"
   "../public"
   "../.."
   "../../include"
   "../../inc"
   "../../common"
   "../../public"
   )
  )

(let ((include-dirs cedet-user-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))  

(global-ede-mode 1)

(global-semantic-idle-scheduler-mode 1)

(provide 'init-ccpp)
