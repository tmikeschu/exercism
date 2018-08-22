(ns run-length-encoding)

(def char-reducer #(if (= (ffirst %1) %2)
                     (apply conj ((juxt pop (comp (partial cons %2) peek)) %1))
                     (conj %1 (list %2))))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (->> plain-text
       (reduce char-reducer '())
       (map (juxt count (comp str first)))
       (map (partial filter #(not= 1 %)))
       (map (partial reduce str ""))
       (reverse)
       (reduce str ""))
  )

(defn- isDigit [c] (->> c str (re-find #"^\d")))

(defn prepend-string [c] #(str c %))
(def cipher-reducer #(if (isDigit %2)
                       (apply conj ((juxt pop (comp (prepend-string %2) peek)) %1))
                       (apply conj ((juxt pop 
                                          (comp (() %2) (partial repeat) read-string peek)
                                          ) %1))
                              
                       ))
(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (->> cipher-text
       (reduce cipher-reducer '())
       (reduce str "")
  ))
