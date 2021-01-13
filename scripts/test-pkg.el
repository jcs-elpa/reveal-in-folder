;;
;; (@* "Prepare" )
;;

(add-to-list 'load-path "./")
(load-file (expand-file-name "./scripts/pkg-prepare.el"))

(jcs-ensure-package-installed '(f s) t)

;;
;; (@* "Test" )
;;

(require 'reveal-in-folder)
(reveal-in-folder)
