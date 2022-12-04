;;; Puzzle 5 Advent of code 2022

;;; Code:
(defun split-in-two (string)
  "Given an string it splits it in two by the middle"
  (let ((middle (/ (length string) 2)))
    (list (substring string 0 middle) (substring string middle))
    )
  )

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
(message "%s" (char-to-score ?v))
(defun normalized-line ()
  "Returns current line without the \n"
  (replace-regexp-in-string "\n$" "" (thing-at-point 'line))
  )

(defun process-file ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((sum 0))
      (while (not (eobp))
	(let ((current-string (normalized-line)))
	  (with-current-buffer "*scratch*"
	    (insert  (format "%s" (shared-chars (split-in-two current-string))))
	    (insert "\n")
	    )
	  (let ((chars (shared-chars (split-in-two current-string))))
	    (dolist (element chars)
	      (with-current-buffer "*scratch*"
		    (insert  (format "%s" (char-to-score element)))
		    (insert "\n")
		    )

	      (setq sum (+ sum (char-to-score element)))
	      )
	    (forward-line)
	    )
	  )
	)
      sum
      )
    )
  )
(message "%s" (process-file))
