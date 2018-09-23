(ns run-length-encoding)
(alias 'S 'clojure.string)

(defn strip-1
  "removes preceding 1s from a string"
  [s]
  (S/replace s #"^1[^\d]" (subs s 1)))

(defn append-to-last
  [el coll]
  (conj (pop coll) (conj (peek coll) el)))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (->> plain-text
       (reduce
         #(if (= (peek (peek %1)) %2)
            (append-to-last %2 %1)
            (conj %1 (vector %2)))
         (vector (vector)))
       (filter (comp not empty?))
       (map (comp strip-1 S/join (juxt count peek)))
       S/join))


(defn get-quantity [s] (Integer. (or (re-find #"\d+" s) "1")))
(defn get-letter [s] (re-find #"(?i)[a-z ]" s))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (->> cipher-text
       (re-seq #"(?i)\d+[a-z ]|[a-z ]")
       (map (comp
              S/join 
              (partial apply repeat)
              (juxt get-quantity get-letter)))
       S/join
    ))
