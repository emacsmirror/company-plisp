(require 's)
(require 'cl-lib)
(require 'company)

(defun get-lista (prefix)
  (s-lines (shell-command-to-string
	    (concat "pil ""/home/fermin/Programming/company-plisp/plisp-l.l "  "/home/fermin/Programming/company-plisp/company-plisp.l" " -" prefix " -bye"))))
(get-lista "\\<h")

(defun compay-plisp-load-libraries ()
  ""
  (interactive)
  )

(-filter (lambda (line)(progn (when (posix-string-match "\(load\s+[\"][@]?[[:word:]]+[\\/]?[[:word:]]+\\.l[\"]" line)
				(message "%s" line))))
	 (s-lines (buffer-substring-no-properties  1 (buffer-end 1))))

(posix-string-match "\(load\s+[\"][@]?[[:word:]]+[\\/]?[[:word:]]+\\.l[\"]"  "(load \"@lib/xhtml.l\")")

(defconst sample-completions
  '("elenecico" "john" "ada" "don"))
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

