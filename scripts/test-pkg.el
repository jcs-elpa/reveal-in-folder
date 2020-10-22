;;
;; (@* "Prepare" )
;;

(load-file (expand-file-name "./scripts/pkg-prepare.el"))

(jcs-ensure-package-installed '(f s) t)

(load-file (expand-file-name "./reveal-in-folder.el"))

;;
;; (@* "Test" )
;;


(defun reveal-in-folder--signal-shell (path)
  "Send the shell command by PATH."
  (let ((default-directory
          (if path (f-dirname (expand-file-name path)) default-directory))
        (buf-name (if (and reveal-in-folder-select-file (buffer-file-name))
                      (shell-quote-argument (expand-file-name (buffer-file-name)))
                    nil))
        cmd)
    (cond
     ;; Windows
     ((memq system-type '(cygwin windows-nt ms-dos))
      (cond (buf-name
             (setq buf-name (s-replace "/" "\\" buf-name))
             (setq cmd (format "explorer /select,%s" buf-name)))
            ((ignore-errors (file-directory-p path))
             (setq path (s-replace "/" "\\" path))
             (setq cmd (format "explorer /select,%s" path)))
            (t (setq cmd "explorer ."))))
     ;; macOS
     ((eq system-type 'darwin)
      (cond (buf-name
             (setq cmd (format "open -R %s" buf-name)))
            ((ignore-errors (file-directory-p path))
             (setq cmd (format "open -R %s" path)))
            (t (setq cmd "open ."))))
     ;; Linux
     ((eq system-type 'gnu/linux)
      (setq cmd "xdg-open .")
      ;; TODO: I don't think Linux has defualt way to do it across all distro.
      )
     ;; BSD
     ((eq system-type 'berkeley-unix)
      ;; TODO: Not sure what else command do I need to make it work in BSD.
      (setq cmd "open .")
      (cond (buf-name
             (setq cmd (format "open -R %s" buf-name)))
            ((ignore-errors (file-directory-p path))
             (setq cmd (format "open -R %s" path)))
            (t (setq cmd "open ."))))
     (t (error "[ERROR] Unknown Operating System type")))
    (when cmd (reveal-in-folder--safe-execute-p cmd))))


(reveal-in-folder-this-buffer)
