(ns hamming)

(defn distance [& strands]
  (when (apply = (map count strands))
  (->> strands
       (apply map =)
       (remove identity)
       count)))
