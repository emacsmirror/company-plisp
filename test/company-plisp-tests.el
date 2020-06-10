;;; company-plisp.el --- Tests for company-plisp

;; Author: Fermin MF <fmfs@posteo.net>
;; Created: 8 June 2020
;; Version: 0.0.1
;; URL: https://gitlab.com/sasanidas/company-plisp
;; Package-Requires: ((emacs "25") (s "1.2.0") (f "0.16.0") (company "0.8.12") (dash "2.12.0") (cl-lib "0.5"))

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Tests for company-lisp.

;;; Code:


(require 'company-plisp)
(require 'ert)

(require 'f)

(ert-deftest company-plisp-test-executable ()
  (should (f-file? company-plisp-pil-exec)))


(ert-deftest company-plisp-test-load-libraries ()
  (with-temp-buffer
    (insert "(load \"@ext.l\" \"@lib/http.l\" \"@lib/xhtml.l\" \"@lib/form.l\")")
    (let* ((loaded-file (company-plisp--load-libraries)))
      (should (f-file? loaded-file))

      (should (equal "" (shell-command-to-string
			 (concat company-plisp-pil-exec " " loaded-file " -bye") ))))))

(ert-deftest company-plisp-test-completion-backend ()
  (should (listp (company-plisp--backend "s")))
  (should-not (equal (length (company-plisp--backend "set")) 1)))







;;; company-plisp-tests.el ends here
