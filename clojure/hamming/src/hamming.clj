(ns hamming)

(defn zip-to-set [a b] (map hash-set a b))

(defn- mismatches [a] (not= 1 (count a)))

(defn distance [& strands]
  (when (apply = (map count strands))
  (->> strands
       (apply zip-to-set)
       (filter mismatches)
       count)))
