(ns queen-attack
  (:require [clojure.string :refer [join]]))

(def init-board (repeat 8 (repeat 8 nil)))

(defn place-queen-on-board [queen mark board]
  (map-indexed
    (fn [i row]
      (map-indexed
        (fn [j cell] (if (= [i j] queen) mark cell))
        row))
    board))

(defn board-string [{w :w b :b}]
  (->> init-board
       (place-queen-on-board w "W")
       (place-queen-on-board b "B")
       (map (fn [row]
              (->> row
                   (map #(or %1 "_"))
                   (join " "))))
       (reduce #(str %1 %2 "\n") "")))

(defn abs [x] (if (neg? x) (- x) x))

(defn slope [a b]
  (try (apply / (map (comp abs -) a b))
       (catch Exception e 0)))

(defn can-attack [{w :w b :b}]
  (->> [w b]
       (apply (juxt (partial map /) slope))
       flatten
       (some (partial = 1))
       boolean))
