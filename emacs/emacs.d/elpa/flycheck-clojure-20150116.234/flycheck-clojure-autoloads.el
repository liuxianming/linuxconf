;;; flycheck-clojure-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (flycheck-clojure-setup flycheck-clojure-parse-cider-errors)
;;;;;;  "flycheck-clojure" "flycheck-clojure.el" (21759 62457 345243
;;;;;;  98000))
;;; Generated autoloads from flycheck-clojure.el

(autoload 'flycheck-clojure-parse-cider-errors "flycheck-clojure" "\
Parse cider errors from JSON VALUE from CHECKER.

Return a list of parsed `flycheck-error' objects.

\(fn VALUE CHECKER)" nil nil)

(autoload 'flycheck-clojure-setup "flycheck-clojure" "\
Setup Flycheck for Clojure.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("flycheck-clojure-pkg.el") (21759 62457
;;;;;;  348388 827000))

;;;***

(provide 'flycheck-clojure-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; flycheck-clojure-autoloads.el ends here