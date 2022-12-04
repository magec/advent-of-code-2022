;;; Puzzle 3 Advent of code 2022

(setq scores '(
	       (("A" "X") 4) ;; 1 + 3
	       (("A" "Y") 8) ;; 2 + 6
	       (("A" "Z") 3) ;; 3 + 0
	       (("B" "X") 1) ;; 1 + 0
	       (("B" "Y") 5) ;; 2 + 3
	       (("B" "Z") 9) ;; 3 + 6
	       (("C" "X") 7) ;; 1 + 6
	       (("C" "Y") 2) ;; 2 + 0
	       (("C" "Z") 6) ;; 3 + 3
	       )
      )

(defun process-file ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((sum 0))
      (while (not (eobp))
	(let
	    ((current-list (split-string (replace-regexp-in-string "\n$" "" (thing-at-point 'line)) " ")))
	  (let
	      ((current-number (or (car (cdr (assoc current-list scores))) 0 )))

	    (setq sum (+ sum current-number))
            (forward-line)
	    )
	  )
	)
      sum
      )
    )
  )

(message "%s" (process-file))
