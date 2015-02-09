(setq auto-save-mode nil)
(setq make-backup-files nil)

(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;;--------------------Configure cedet-----------------------------------------
(require 'cedet)
(require 'semantic)
(require 'semantic/ia)
(semantic-mode 1)
(global-ede-mode 1)
;(global-srecode-minor-mode 1)           

;;set include dirs
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "./include"
        "../.." "../../include" "../../inc" "../../common" "../../public" "/usr/local/cuda/include"))

;;--------------------Auto Indent---------------------------------------------
(electric-indent-mode 1)
;;Auto indent for python
;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'python-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-python)

;; Enter key executes newline-and-indent
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'python-mode-hook 'set-newline-and-indent)

;;-------------------End auto indent------------------------------------------

;;set semantic-fast-jump
(global-set-key [f12] 'semantic-ia-fast-jump)

(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)

;;code complete: using alt - n
;(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu)

;;ede - project management
(global-ede-mode t)

;;----------------------------------------------------------------------------

;;Load_path
(add-to-list 'load-path' "~/.emacs.d/plugins")
(add-to-list 'load-path' "~/.emacs.d")
(add-to-list 'load-path' "~/.emacs.d/elpa")

;; start auto-complete with emacs
(require  'auto-complete)
(require  'auto-complete-config)
(ac-config-default)

;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

;; define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.6")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.6/include")
)
;now call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;;--------------------Python setup --------------------
;(load-library "init_python")
;---------------------end python ---------------------

;; cuda setup
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))

;;Time display settings
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;==============color setting=======================
(package-initialize)
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(require 'color-theme-solarized)
(color-theme-solarized-dark)


(setq default-frame-alist
'((height . 32) (width , 50) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;;(set-default-font "Droid Sans Mono-10")
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq default-major-mode 'text-mode)
(setq inhibit-startup-message t)
(auto-save-mode 0)
(global-font-lock-mode t)

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)


(setq scroll-margin 3
       scroll-conservatively 10000)

;; show row numbers
(column-number-mode t)

;; show column numbers
(setq mouse-yank-at-point t)

;; remove menu, and use f10 to call
(menu-bar-mode nil)

(mouse-avoidance-mode 'animate)
(setq mouse-yank-at-point t)
(transient-mark-mode t)

;; show current location in title
(setq frame-title-format "Xianming Liu@%b")

;; user C-k to delete everything from cursor to the end of line
(setq-default kill-whole-line t)

;; code fold
(load-library "hideshow")
(require 'google-c-style)
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'cperl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; ================== programming settings ====================
(global-set-key [f5] 'compile)
(setq-default compile-command "make -j8")
(global-set-key [f6] 'speedbar)
(global-set-key [f7] 'gdb)
(global-set-key [f8] 'previous-error)
(global-set-key [f9] 'next-error)
;;start gdb   
(global-set-key [f10] 'gdb-many-windows)


;;======================            拷贝代码自动格式化          =====================
;;Emacs 里对代码的格式化支持的非常好，不但可以在编辑的时候自动帮你格式化，还可以选中一块代码，
;;按 Ctrl-Alt-\ 对这块代码重新进行格式化.如果要粘贴一块代码的话，粘贴完了紧接着按 Ctrl-Alt-\,
;;就可以把新加入的代码格式化好。可是，对于这种粘贴加上重新格式化的机械操作，Emacs 应该可以将
;;它自动化才能配得上它的名气，把下面的代码加到配置文件里，你的 Emacs 就会拥有这种能力了
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(
                     c-mode
                     c++-mode
                     clojure-mode
                     emacs-lisp-mode
                     haskell-mode
                     js-mode
                     latex-mode
                     lisp-mode
                     objc-mode
                     perl-mode
                     cperl-mode
                     plain-tex-mode
                     python-mode
                     rspec-mode
                     ruby-mode
                     scheme-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))
;;----------------------            End 拷贝代码自动格式化        ---------------------

;;---------------------- Configuration of cscope    -----------------------------------
(load "xcscope")
;;(require 'xcscope')

(add-hook 'c-mode-common-hook
	  '(lambda ()
	    (require 'xcscope))) 
