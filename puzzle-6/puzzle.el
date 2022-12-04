;;; Puzzle 6 Advent of code 2022

;;; Code:
(defun shared-chars (string-list)
  "Returns the shared chars in both string"
  (let ((shared ())
	(first-string (car string-list))
	(second-string (car (cdr string-list))))
    (cl-loop for char across first-string do
	     (if (seq-contains second-string char)
	       (push char shared)
	       )
	     )
    (delete-dups shared)
    )
  )

(defun string-is-capitalized (str)
  (let ((case-fold-search nil))
    (string-match-p "\\`[A-Z]*\\'" str)))


(defun char-to-score (char)
  "Returns the score of a given char"
  (if (string-is-capitalized (char-to-string char))
      (- char 38)
    (- char 96)
    )
  )

(defun normalized-line ()
  "Returns current line without the \n"
  (replace-regexp-in-string "\n$" "" (thing-at-point 'line))
  )

(defun process-file ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((sum 0))
      (while (not (eobp))
	(let ((first-elf (normalized-line)))
	  (forward-line)
	  (let ((second-elf (normalized-line)))
	    (forward-line)
	    (let ((third-elf (normalized-line))
		  (shared-first-second (delete-dups (shared-chars (list first-elf second-elf)))))
	      (dolist (element shared-first-second)
		(if (seq-contains third-elf element)
		    (setq sum (+ sum (char-to-score element)))
		  )
		)
	      )
	    )
	  (forward-line)
	  )
	)
      sum
      )
    )
  )
(message "%s" (process-file))
