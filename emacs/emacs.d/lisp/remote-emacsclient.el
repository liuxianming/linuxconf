;; Allow external clients to open buffers.  Specifically, this is full of
;; lovely hacks that allow me to have a remote emacsclient-alike cause a file
;; to be opened through the clever use of tramp connections.
;;
;; We start with the libraries we are about to abuse...
(require 'server)
(require 'tramp)
(require 'tramp-sh)                     ; defines the methods :(

;; Use local backups of tramp files.  I have sufficiently strict security on
;; machines where I use tramp that I consider this reasonable.
(defconst dp/tramp-backup-dir
  (expand-file-name (locate-user-emacs-file "tramp-backups"))
  "The (local) directory into which to backup tramp files.")
(or (file-directory-p dp/tramp-backup-dir)
    (make-directory dp/tramp-backup-dir))
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp dp/tramp-backup-dir))

(defconst dp/tramp-autosave-dir
  (expand-file-name (locate-user-emacs-file "tramp-autosaves"))
  "The (local) directory into which to autosave tramp files.")
(or (file-directory-p dp/tramp-autosave-dir)
    (make-directory dp/tramp-autosave-dir))
(setq tramp-auto-save-directory dp/tramp-autosave-dir)


;; This is actually too long for unix sockets on OS-X, and not much of a win
;; for me anyhow because the security policy at FB prevents it being
;; used anyhow.
(setq tramp-use-ssh-controlmaster-options nil)

;; (aput 'tramp-methods "fb"
;;   '((tramp-login-program        "ssh")
;;     (tramp-login-args           (("-l" "%u") ("-p" "%p")
;; 				 ("-e" "none") ("-t" "-t")
;; 				 ("%h") ("/bin/sh")))
;;     (tramp-async-args           (("-q")))
;;     (tramp-remote-shell         "/bin/sh")
;;     (tramp-remote-shell-args    ("-c"))
;;     (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
;; 				 ("-o" "UserKnownHostsFile=/dev/null")
;; 				 ("-o" "StrictHostKeyChecking=no")))
;;     (tramp-copy-program         "sftp")
;;     (tramp-copy-args            (("-P" "2") ("-p" "%k") ("-q") ("-r")))
;;     (tramp-default-port         22)))
;; (tramp-set-completion-function "fb" tramp-completion-function-alist-ssh)

(setq tramp-default-method "sshx")


(defcustom tramp-remote-emacsclient-auth-file
  "~/.emacs.d/remote-server"
  "Default remote path at which to save the remote emacsclient
authentication file. This can be a string or nil to disable
saving an authentication file.

The authentication file is similar to the one written out by the
emacsclient TCP server, except it includes the prefix used for
the TRAMP connection to the remote server."
  :group 'tramp
  :type '(choice (const nil) string))

(defun tramp-make-tramp-file-name-from-vec (vec file)
  "Convenience function for making a TRAMP path, since this
apparently didn't already exist."
  (tramp-make-tramp-file-name
    (tramp-file-name-method vec)
    (tramp-file-name-user vec)
    (tramp-file-name-host vec)
    file))

(defun tramp-get-remote-emacsclient-hack-file (vec file)
  "Determine the full TRAMP path for the remote emacsclient
hack file, given a connection vector and a filename."
  (when file (tramp-make-tramp-file-name-from-vec vec file)))

(defun tramp-save-remote-emacsclient-auth-file (&optional vec)
  "Write the remote emacsclient authentication file for a given
connection buffer, or, if used interactively, for the TRAMP
connection of the current buffer."
  (interactive)
  (let ((vec (or vec (tramp-dissect-file-name default-directory))))
    (condition-case err
        (let ((auth-file (tramp-get-remote-emacsclient-hack-file
                          vec tramp-remote-emacsclient-auth-file))
              (port      (process-contact server-process :service))
              (auth      (process-get server-process :auth-key)))
          (if auth-file
              (progn
                (make-directory (file-name-directory auth-file) t)
                (with-temp-file auth-file
                  (insert
                   (format "127.0.0.1 %d\n" port)
                   (format "-auth %s\n" auth)
                   (server-quote-arg (tramp-make-tramp-file-name-from-vec vec ""))
                   "\n")))
            (when (called-interactively-p 'any)
              (message "No remote emacsclient auth file for %s"
                       default-directory))))
      (file-error (message "error saving remote emacsclient auth: %s" err)))))

(defadvice tramp-open-connection-setup-interactive-shell
  (after copy-server-file-by-tramp (proc vec) activate)
  "Automatically write out a remote emacsclient auth file after a
successful connection."
  (tramp-save-remote-emacsclient-auth-file vec))


;; Finally, make sure we listen for TCP connections, and fire off the server.
;; This triggers the various TRAMP hacks to fire up, and we will then
;; auto-install our remote utilities, security data, etc, on first connection
;; to the remote server.
(setq server-use-tcp t
      server-port    29398)
;; (setq server-use-tcp nil)
(server-start)


;; For mostly worse, hg + FB extensions + tramp don't play nice with vc-hg,
;; so these hacks follow.  reported via report-emacs-bug, so hopefully they
;; will fix it forever upstream

;;(require 'vc-hg)
(delq 'Hg vc-handled-backends)
(eval-after-load 'tramp-sh
  '(setq tramp-remote-process-environment
         (cl-list* "HGPLAIN=1"
                   "PAGER=cat"
                   (cl-delete "^PAGER=" tramp-remote-process-environment :test 'string-match))))
(setenv "HGPLAIN" "1")


;; ...and bind in code to make it *easier* to dismiss that buffer than the
;; default binding with two chording keystrokes in wildly different locations.
(defun dp/server-visit-handler ()
  (local-set-key (kbd "C-c C-c") #'server-edit))
(add-hook 'server-visit-hook #'dp/server-visit-handler)

(provide 'remote-emacsclient)
