;;; Puzzle 9 Advent of code 2022
;;; Code:

(defun initial-state ()
  "Returns the initial state of the puzzle"
  '(
    (R N F V L J S M)
    (P N D Z F J W H)
    (W R C D G)
    (N B S)
    (M Z W P C B F N)
    (P R M W)
    (R T N G L S W)
    (Q T H F N B V)
    (L M H Z N F)
    )
  )


(defun extract-move (line)
  "Extracts the move in list from from human readable text."
  "move 1 from 7 to 6 -> (1 7 6)"
  (let ((splitted-line (split-string line " ")))
    (mapcar 'string-to-number (list (nth 1 splitted-line) (nth 3 splitted-line) (nth 5 splitted-line)))
    )
 )

(defun debug-in-scratch (thing)
  "Writes the thing in scratch"
  (with-current-buffer "*scratch*"
    (insert (format "%s" thing))
    )
  )

(defun set-nth (list n value)
  (let ((output (copy-tree list)))
    (setcar (nthcdr (- n 1) output ) value)
      output
      )
  )

(defun first-n-elements (list n)
  (butlast list (- (length list) n))
)

(defun apply-move (move state)
  "Applies a move to a given state and returns the new state"
  (let ((number-of-elements (car move))
	(from (nth 1 move))
	(to (nth 2 move)))
    (let ((from-list (nth (- from 1) state))
	  (to-list (nth (- to 1) state)))
      (let ((elements-to-be-added  (first-n-elements (reverse from-list) number-of-elements)))
	(let ((new-target (append to-list elements-to-be-added))
	      (new-source (butlast from-list number-of-elements))
	      )
	  (setq state (set-nth (set-nth state from new-source) to new-target))
	  )
	)
      )
    state
    )
  )

(defun last-elements (list)
  "returns list with last elements of a list of lists"
  (let ((output '()))
    (dolist (element list)
      (setq output (append output (list (car (reverse element)))))
      )
    output
    )
  )


(defun normalized-line ()
  "Returns current line without the \n"
  (replace-regexp-in-string "\n$" "" (thing-at-point 'line))
  )

(defun process-file (state)
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (while (not (eobp))
      (let ((move (extract-move (normalized-line))))
	(setq state (apply-move move state))
	)
      (forward-line)
      )
    )
  (last-elements state)
  )


(message "%s" (process-file (initial-state)))
