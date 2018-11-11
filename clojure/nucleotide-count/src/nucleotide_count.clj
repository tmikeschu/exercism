(ns nucleotide-count)

(def base {\A 0, \T 0, \C 0, \G 0})

(def nucleotide-counts (comp (partial merge base) frequencies))

(defn count
  [nucleotide strand]
  (if (contains? base nucleotide)
    ((nucleotide-counts strand) nucleotide)
    (throw (Exception. "not allowed"))))
