(ns armstrong-numbers)

(defn ** [x n] (->> x (repeat n) (reduce *)))

(defn armstrong? [num]
  (let [len (-> num str count)]
    (->> num 
         str
         (map #(-> % str read-string (** len)))
         (reduce +)
         (== num))))
