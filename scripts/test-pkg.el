;;
;; (@* "Prepare" )
;;

(add-to-list 'load-path "./")
(add-to-list 'load-path "./scripts/")
(require 'pkg-prepare)

(jcs-ensure-package-installed '(f s) t)

;;
;; (@* "Test" )
;;

(require 'reveal-in-folder)
(reveal-in-folder)
