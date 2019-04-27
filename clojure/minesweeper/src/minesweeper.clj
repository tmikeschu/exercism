(ns minesweeper
  (:require 
    [clojure.string :refer [lower-case]]))

(defn neighbors-of [x y]
  (let [neighbors [[-1,  1], [0,  1], [1,  1],
                   [-1,  0],          [1,  0],
                   [-1, -1], [0, -1], [1, -1]]]
    (set (map (partial map + [x, y]) neighbors))))

(defn generate-cell [mine-neighbors y x]
  (if (contains? mine-neighbors [x y]) 1 0))

(defn generate-line [mine-neighbors width y]
  (map
    (partial generate-cell mine-neighbors y)
    (range 0 width)))

(defn generate-board [{h :h w :w} mine-neighbors]
  (mapcat (partial generate-line mine-neighbors w)
          (range 0 h)))

(def mine?  (partial = \*))

(defn board-for-cell [dimensions y x cell]
  (generate-board dimensions (if (mine? cell) (neighbors-of x y))))

(defn boards-for-line [dimensions line y]
  (map (partial board-for-cell dimensions y)
       (range 0 (dimensions :w))
       line))

(defn sum-up [& vals] (reduce + vals))

(defn draw [input]
  (let [lines (clojure.string/split-lines input)
        dimensions {:w (count (first lines)) :h (count lines)}]
    (->> (mapcat (partial boards-for-line dimensions)
                 lines
                 (range 0 (dimensions :h)))
         (apply map sum-up)
         (map #(if (zero? %) \space (str %)))
         (partition (dimensions :w))
         (map (partial reduce str))
         (interpose "\n")
         (reduce str)
         (map #(if (= \* %1) %1 %2) input)
         (reduce str))))
