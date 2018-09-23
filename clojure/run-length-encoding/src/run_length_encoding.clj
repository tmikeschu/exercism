(ns run-length-encoding)

(def re-char "(?i)[a-z ]")
(def re-int "\\d+")

(def coll-to-str (partial reduce str))

(defn- strip-1
  "removes preceding 1s from a string"
  [s]
  (clojure.string/replace s #"^1[^\d]" (subs s 1)))

(defn- append-to-last
  [el coll]
  (conj (pop coll) (conj (peek coll) el)))

(defn- get-quantity [s] (Integer. (or (re-find (re-pattern re-int) s) 1)))

(defn- get-letter [s] (re-find (re-pattern re-char) s))

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
       (map (comp strip-1 coll-to-str (juxt count peek)))
       coll-to-str))


(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (->> cipher-text
       (re-seq (re-pattern (str re-int re-char "|" re-char)))
       (map (comp
              coll-to-str
              (partial apply repeat)
              (juxt get-quantity get-letter)))
       coll-to-str))
