;; company-razor.el --- Company completions for python razor  -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Marcos Cesar Gritti

;; Author: Marcos Cesar Gritti <cesargritti@gmail.com>
;; Keywords: ultima online, razor enhanced
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package implements a company backend for Razor Enhanced specifics
;; python objects.

;;; Code:
(require 'cl-lib)
(require 'company)

(defgroup company-razor nil
  "Completion backend for Razor Enhanced IronPython."
  :group 'company)

(defconst cr--completions
  '(#("Player" 0 1 (:meta "Gather player information" :type "Class")))
  "Razor script completions")

(defconst cr--player-completions
  '(#("Hits" 0 1 (:meta "Retrieve character hits" :type "int"))
    #("HitsMax" 0 1 (:meta "Retrieve character max hits" :type "int"))
    #("Str" 0 1 (:meta "Retrieve character strength" :type "int"))
    #("Mana" 0 1 (:meta "Retrieve character mana" :type "int"))
    #("ManaMax" 0 1 (:meta "Retrieve character max mana" :type "int"))
    #("Intelligence" 0 1 (:meta "Retrieve character intelligence" :type "int"))
    #("Stamina" 0 1 (:meta "Retrieve character stamina" :type "int")))
  "Player object completions.")

(defvar company-razor-completions nil
  "Current selected completions")

(defun company-razor--set-completion-list (prefix list)
  "Sets the context completion list and returns the prefix. Returns nil if list has no matches"
  (let ((filtered (company-razor--filter-from-list prefix list)))
    (when filtered
      (setq company-razor-completions filtered)
      prefix)))

(defun company-razor--filter-from-list (prefix list)
  "Remove from completion list members that does not have *PREFIX*."
  (cl-remove-if-not
   (lambda (c) (string-prefix-p prefix c)) list))

(defun company-razor--get-completion-prefix (symbol)
  "Returns prefix from a symbol and sets the completion context."
  (let* ((splited (split-string symbol "\\."))
	 (but-last (reverse (cdr (reverse splited))))
	 (key (mapconcat 'identity but-last "."))
	 (prefix (nth (- (length splited) 1) splited)))
    (pcase key
      ("Player" (company-razor--set-completion-list prefix cr--player-completions))
      (default (company-razor--set-completion-list prefix cr--completions)))))

(defun company-razor-prefix ()
  "Get a prefix from current position."
  (let* ((symbol (company-grab-symbol-cons "\\." 2)))
    (company-razor--get-completion-prefix symbol)))

(defun company-razor-meta (completion)
  "Get completion meta"
  (get-text-property 0 :meta completion))

(defun company-razor-annotation (completion)
  "Get completion annotation"
  (format " [%s]" (get-text-property 0 :type completion)))

;;;###autoload
(defun company-razor (command &optional arg &rest ignored)
  "Provide completion info according to COMMAND and ARG."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-razor))
    (prefix (company-razor-prefix))
    (candidates company-razor-completions)
    (annotation (company-razor-annotation arg))
    (meta (company-razor-meta arg))))

(provide 'company-razor)
;;; company-razor.el ends here
