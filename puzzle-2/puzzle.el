;;; Puzzle 2 Advent of code 2022

(defun current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at-p "[[:blank:]]*$")))

(defun process-file ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((list '()))
      (while (not (eobp))
        (let ((sum 0))
          (while (not (current-line-empty-p))
	    (setq sum (+ sum (number-at-point)))
            (forward-line)
            )
	  (add-to-list 'list sum)
	  (forward-line)
          )
        )
      (setq list (sort list '>))
      (apply '+ (butlast list (- (length list) 3)))
      )
    )
  )

(message "%s" (process-file))
