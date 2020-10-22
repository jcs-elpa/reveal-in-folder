;;
;; (@* "Prepare" )
;;

(load-file (expand-file-name "./scripts/pkg-prepare.el"))

(jcs-ensure-package-installed '(f s) t)

(load-file (expand-file-name "./reveal-in-folder.el"))

;;
;; (@* "Test" )
;;

(reveal-in-folder-this-buffer)
