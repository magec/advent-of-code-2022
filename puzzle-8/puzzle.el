;;; Puzzle 8 Advent of code 2022

;;; Code:
(defun normalized-line ()
  "Returns current line without the \n"
  (replace-regexp-in-string "\n$" "" (thing-at-point 'line))
  )

(defun process-file ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((sum 0))
      (while (not (eobp))
	(if (overlaps-p (split-string (normalized-line) ","))
	    (setq sum (+ sum 1))
	  )
	(forward-line)
	)
      sum
      )
    )
  )

(defun split-in-numbers (range)
  "Splits a range in a list of two numbers"
  (mapcar 'string-to-number (split-string range "-"))
  )

(defun overlaps-p (ranges)
  "Returns true if first-range overlaps over second-range"
  (let ((first-range (car ranges))
	(second-range (car (cdr ranges))))
    (let ((first-number-first-range  (car (split-in-numbers first-range)))
	  (second-number-first-range  (car (cdr (split-in-numbers first-range))))
	  (first-number-second-range  (car (split-in-numbers second-range)))
	  (second-number-second-range  (car (cdr (split-in-numbers second-range))))
	  )
      (and (<= first-number-first-range second-number-second-range)
	  (<= first-number-second-range second-number-first-range)
	)
      )
    )
  )

(message "%s" (process-file))
