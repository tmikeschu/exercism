(ns nucleotide-count)

(def base {\A 0, \T 0, \C 0, \G 0})

(defn nucleotide-counts [strand]
  (reduce #(assoc %1 %2 (inc (%1 %2 0))) base strand))

(defn count [nucleotide strand]
  (if (contains? base nucleotide)
    ((nucleotide-counts strand) nucleotide)
    (throw (Exception. "not allowed"))))
