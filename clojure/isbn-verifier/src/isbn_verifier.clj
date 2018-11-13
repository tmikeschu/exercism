(ns isbn-verifier)
(require '[clojure.string :as s])

(defn isbn? [isbn]
  (let [factors (reverse (range 1 11))]
    (true?
      (when
        (re-matches #"^\d-?\d{3}-?\d{5}-?[\dX]$" isbn)
        (-> isbn
            (s/replace #"-" "")
            (->> (re-seq #"\d|X$")
                 (replace {"X" 10})
                 (map #(Integer. %))
                 (map * factors)
                 (reduce +))
            (rem 11)
            zero?)))))
