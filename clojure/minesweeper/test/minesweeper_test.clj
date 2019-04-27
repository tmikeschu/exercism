(ns minesweeper-test
  (:require [clojure.test :refer [deftest is]]
            minesweeper))

(deftest neighbors-of-returns-neighbors
  (is (= (set [[1 4] [2 4] [3 4]
               [1 3]       [3 3]
               [1 2] [2 2] [3 2]])
         (minesweeper/neighbors-of 2 3))))

(deftest generate-cell-returns-zero-if-not-in-mine-neighbors
  (is (= 0
         (minesweeper/generate-cell (minesweeper/neighbors-of 3 3) 1 1))))

(deftest generate-cell-returns-if-in-mine-neighbors
  (is (= 1
         (minesweeper/generate-cell (minesweeper/neighbors-of 3 3) 3 2))))

(deftest generate-line-returns-row-of-cell-marks
  (is (= '(0 1 1 1 0)
         (minesweeper/generate-line (minesweeper/neighbors-of 2 1) 5 0))))

(deftest generate-line-returns-row-of-cell-marks-2
  (is (= '(0 1 0 1 0)
         (minesweeper/generate-line (minesweeper/neighbors-of 2 1) 5 1))))

(deftest generate-line-returns-row-of-cell-marks-3
  (is (= '(0 0 0 0 0)
         (minesweeper/generate-line (minesweeper/neighbors-of 2 1) 5 5))))

(deftest generate-board-makes-a-grid-based-on-width-and-height
  (is (= '(1 1 1
           1 0 1
           1 1 1) 
         (minesweeper/generate-board {:w 3 :h 3} (minesweeper/neighbors-of 1 1)))))

(deftest generate-board-makes-a-grid-based-on-width-and-height-2
  (is (= '(1 1 1 0
           1 0 1 0
           1 1 1 0
           0 0 0 0
           0 0 0 0) 
         (minesweeper/generate-board {:w 4 :h 5} (minesweeper/neighbors-of 1 1)))))

(deftest board-for-cell-returns-zeros-for-non-asterisk
  (is (= '(0 0 0 0
           0 0 0 0
           0 0 0 0
           0 0 0 0) 
         (minesweeper/board-for-cell {:w 4 :h 4} 1 1 \space))))

(deftest board-for-cell-returns-ones-for-asterisk
  (is (= '(0 1 1 1
           0 1 0 1
           0 1 1 1
           0 0 0 0) 
         (minesweeper/board-for-cell {:w 4 :h 4} 1 2 \*))))

(deftest boards-for-line-returns-a-list-of-boards-for-a-y-line
  (is (= (list (repeat 9 0)
           (repeat 9 0)
           '(0 1 0
             0 1 1
             0 0 0)) 
         (minesweeper/boards-for-line {:w 3 :h 3} "  *" 0))))

(deftest draw-takes-input-string-and-makes-board
  (is (= "1*2\n13*\n 2*"
         (minesweeper/draw " * \n  *\n  *"))))
