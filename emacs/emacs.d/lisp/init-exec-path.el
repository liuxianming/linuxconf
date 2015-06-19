(require-package 'exec-path-from-shell)

(after-load 'exec-path-from-shell
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE"))
    (add-to-list 'exec-path-from-shell-variables var)))

;; To support jedi on Mac OS
;; pip uninstall epc
;; pip uninstall jedi
;; pip install --upgrade pip
;; pip install epc
;; pip install jedi
(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-env "PYTHONPATH")
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)
