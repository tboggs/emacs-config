;; Custom LaTeX functions

(defvar *gmu-latex-root* "../"
  "The assumed root directory where the main LaTeX file sits. This
   affects how included graphics files are referenced in the files.")

(defvar *gmu-latex-fig-dir* "../figures/"
  "Default location of figures directory.")

(defun gmu-figure (filename caption label)
  "Inserts LaTeX template for a figure in GMU PhD dissertation format.
   The file path will be relative to *gmu-latex-root*."
  (interactive (list
		 (file-name-sans-extension
		   (file-relative-name (read-file-name "File name:"
						       *gmu-latex-fig-dir*)
				       *gmu-latex-root*))
		 (read-string "Caption: ")
		 (read-string "LaTeX label: ")))
  (let ((label-tex (if (> (length label) 0)
		       (format "  \\label{fig:%s}\n" label) "")))
    (insert (format "\\begin{figure}
  \\centering
  \\includegraphics[width=0.5\\linewidth]{%s}
  \\caption{%s}
%s  \\figSpace
\\end{figure}\n\n" filename caption label-tex))))

(defun gmu-multifigure (numfigs caption label)
  "Inserts LaTeX template for a figure with multiple subfigures in GMU PhD dissertation format."
  (interactive (list
		 (read-number "Number of subfigures: ")
		 (read-string "Caption: ")
		 (read-string "LaTeX label: ")))
  (let ((pos (point))
	(figscale (/ 0.95 numfigs)))
    (insert "\\begin{figure}\n  \\centering\n")
    (dotimes (i numfigs)
      (insert (format
		"  \\subcaptionbox{}[%.2f\\linewidth]{\\includegraphics[width=%.2f\\linewidth]{}}\n"
		figscale figscale)))
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
  (let ((pos (point))
	(col-spec (mapconcat 'identity (make-vector (+ numcols 1) "|") "c"))
	(label-tex (if (> (length label) 0)
		   (format "  \\label{tab:%s}\n" label) "")))
    (insert (format
"\\begin{table}
  \\centering
  \\caption{%s}
  \\begin{tabular}{%s}\\\\\\hline
    \\\\\\hline\\hline
    \\\\\\hline
  \\end{tabular}
  \\tableSpace
%s\\end{table}\n\n" caption col-spec label-tex))
    (goto-char pos)
    (forward-line 4)
    (forward-char 4)))


(defun gmu-graphics-path (graphics-path)
  "Inserts the path name of a graphics file without the extension.
   The file path will be relative to *gmu-latex-root*."
  (interactive (list
		 (file-name-sans-extension
		   (file-relative-name (read-file-name "File name:"
						       *gmu-latex-fig-dir*)
				       *gmu-latex-root*))))
  (insert graphics-path))

