(ns rna-transcription)

(def protein-map {\C "G"
                  \G "C"
                  \A "U"
                  \T "A" })

(defn to-rna [dna]
  (->> dna
       (map protein-map)
       (remove nil?)
       (#(if (apply not= (map count [% dna]))
           (throw (AssertionError. "invalid"))
           (apply str %)))))
