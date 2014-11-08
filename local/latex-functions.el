;; Custom LaTeX functions


(defun gmu-figure (filename caption label)
  "Inserts LaTeX template for a figure in GMU PhD dissertation format."
;;  (interactive "sFile name: ")
  (interactive (list
		 (file-name-sans-extension
		   (file-relative-name (read-file-name "File name:") ".."))
		 (read-string "Caption: ")
		 (read-string "LaTeX label: ")))
  (insert (format "\\begin{figure}
  \\centering
  \\includegraphics[width=0.5\\linewidth]{%s}
  \\caption{%s}\n" filename caption))
  (if (> (length label) 0)
      (insert (format "  \\label{fig:%s}\n" label)))
  (insert "  \\figSpace
\\end{figure}\n\n"))

(defun gmu-multifigure (numfigs caption label)
  "Inserts LaTeX template for a figure with multiple subfigures in GMU PhD dissertation format."
;;  (interactive "sFile name: ")
  (interactive (list
		 (read-number "Number of subfigures: ")
		 (read-string "Caption: ")
		 (read-string "LaTeX label: ")))
  (let ((pos (point)))
    (insert "\\begin{figure}\n  \\centering\n")
    (let ((figscale (/ 1.0 numfigs)))
      (dotimes (i numfigs)
	(insert (format
		  "  \\subcaptionbox{}[%.2f\\linewidth]{\\includegraphics[width=%.2f\\linewidth]{}}\n"
		  figscale figscale))))
    (insert (format "  \\caption{%s}\n" caption))
    (if (> (length label) 0)
	(insert (format "  \\label{fig:%s}\n" label)))
    (insert "  \\figSpace\n\\end{figure}\n\n")
    (goto-char pos)
    (forward-line 2)
    (forward-char 17)))


(defun gmu-table (numcols caption label)
  "Inserts LaTeX template for a table in GMU PhD dissertation format."
  (interactive (list
		 (read-number "Number of columns: ")
		 (read-string "Caption: ")
		 (read-string "LaTeX label: ")))
  (let ((pos (point)))
    (insert (format "\\begin{table}\n  \\centering\n  \\caption{%s}\n" caption))
    (insert "  \\begin{tabular}{|")
    (dotimes (i numcols)
      (insert "c|"))
    (insert "}\n    \\hline\n")
    ;; header row
    (insert "    \\\\\\hline\\hline\n")
    ;; first data row
    (insert "    \\\\\\hline\n")
    (insert "  \\end{tabular}\n  \\tableSpace\n")
    (if (> (length label) 0)
      (insert (format "  \\label{tab:%s}\n" label)))
    (insert "\\end{table}\n\n")
    (goto-char pos)
    (forward-line 5)
    (forward-char 4)))

;  (end-of-line -2)
;  (backward-char 1))



