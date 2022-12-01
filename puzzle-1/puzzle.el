;;; Puzzle 1 Advent of code 2022

(defun current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at-p "[[:blank:]]*$")))

(defun process-file ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((max 0))
      (while (not (eobp))
        (let ((sum 0))
          (while (not (current-line-empty-p))
	    (setq sum (+ sum (number-at-point)))
            (forward-line)
            )
	  (if (> sum max)
	      (setq max sum)
	    )
	  (forward-line)
          )
        )
      max
      )
    )
  )

(message "%d" (process-file))
