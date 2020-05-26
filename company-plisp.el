(require 's)
(require 'cl-lib)
(require 'company)
;;Test plisp load
(load "@ext.l" "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")
(defun get-lista (prefix)
  (let* ((library-file (plisp-load-libraries))
	 (completion-list (s-lines (shell-command-to-string
				    (concat "pil " library-file " /home/fermin/Programming/company-plisp/company-plisp.l" " -" prefix " -bye")))))
(f-delete library-file)
completion-list
    )
  )
(get-lista "id")

(defun compay-plisp-load-libraries ()
  ""
  (interactive)
  )

(defun plisp-load-libraries ()
  ""
  (let* ((plisp-temp-l (make-temp-file "plisp_l.l"))
	 (load-lines (-filter (lambda (line)(progn (when (posix-string-match "\(load\s+[\"][@]?[[:word:]]+[\\/]?[[:word:]]+\\.l[\"]" line)
				(message "%s" line))))
			      (s-lines (buffer-substring-no-properties  1 (buffer-end 1))))))
    (-map (lambda (line)
(write-region line nil plisp-temp-l  'append)
	    )
	  load-lines)
(format "%s" plisp-temp-l)))
(plisp-load-libraries)



;; (posix-string-match "\(load\s+[\"][@]?[[:word:]]+[\\/]?[[:word:]]+\\.l[\"]"  "(load \"@lib/xhtml.l\")")

 (defun company-sample-backend (command &optional arg &rest ignored)
   (interactive (list 'interactive))
   (cl-case command
     (interactive (company-begin-backend 'company-sample-backend))
     (prefix (and (eq major-mode 'fundamental-mode)
                 (company-grab-symbol)))
     (candidates
     (cl-remove-if-not
       (lambda (c) (string-prefix-p arg c))
       (get-lista (s-prepend "\\" arg))))))

(add-to-list 'company-backends '(company-sample-backend))

