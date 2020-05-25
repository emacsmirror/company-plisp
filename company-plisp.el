(require 'dash)
(require 's)
(require 'f)
;; (defun read-lines (filePath)
;;   "Return a list of lines of a file at filePath."
;;   (with-temp-buffer
;;     (insert-file-contents filePath)
;;     (split-string (buffer-string) "\n" t)))
;; (split-string (f-read-text "/usr/share/doc/picolisp/doc/refB.html" 'utf-8) "\n" t)


(defun load-plisp--backend (plisp-directory)
   "Load PLISP-DIRECTORY files and extract function names."
   (if (f-exists-p plisp-directory)
   (let* ((files (-filter (lambda (entry) (s-contains? "ref" entry)) (f-entries plisp-directory))))
     (-flatten (-map (lambda (file-path)
		       (let* ((file-string--list  (-filter (lambda (line) (s-contains? "name=" line))
							   (split-string (f-read-text  file-path 'utf-8) "\n" t))))
			 (-map (lambda (file-string)
				 (let* ((name-index (s-index-of "name=" file-string) )
					(string-reduce (substring file-string  name-index))
					(string-last (substring  string-reduce 4 (s-index-of "\">" string-reduce))))
				   ;;Some string have less than 1 length
				   (when (> (length string-last) 2)
				     (substring string-last 2)
				     )
				   )
				 )
			       file-string--list)
			 )
		       )
		     files)))
   (message "Directory %s doesn't exist" plisp-directory))
   )
;; (load-plisp--backend "/usr/share/doc/picolisp/doc/")

;; (f-exists-p "/usr/share/doc/picolisp/doc/")
;; (setq files (-filter (lambda (entry) (s-contains? "ref" entry)) (f-entries "/usr/share/doc/picolisp/doc/")))
;; ;; (s-match (regexp-opt  '("/usr/share/doc/picolisp/doc/refB.html")) "/usr/share/doc/picolisp/doc/refB.html")

;; (-flatten (-map (lambda (file-path)
;; 		  (let* ((file-string--list  (-filter (lambda (line) (s-contains? "name=" line)) (read-lines file-path))))
;; 		    (-map (lambda (file-string)
;; 			    (let* ((name-index (s-index-of "name=" file-string) )
;; 				   (string-reduce (substring file-string  name-index))
;; 				   (string-last (substring  string-reduce 4 (s-index-of "\">" string-reduce))))
;; 			      ;;Some string have less than 1 length
;; 			      (when (> (length string-last) 2)
;; 				(substring string-last 2)
;; 				)
;; 			      )
;; 			    )
;; 			  file-string--list)
;; 		    )
;; 		  )
;; 		files))


;; ;; (setq cadena (nth 6 (-filter (lambda (line) (s-contains? "name" line)) (read-lines "/usr/share/doc/picolisp/doc/refB.html"))))
;; ;; (substring cadena (+ (s-index-of "\"" cadena) 1) (s-index-of "\">" cadena))


