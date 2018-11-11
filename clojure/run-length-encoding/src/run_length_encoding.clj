(ns run-length-encoding)

(defn- get-quantity [s] (Integer. (or (re-find #"\d+" s) 1)))
(defn- get-letter [s] (re-find #"(?i)[a-z ]" s))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (->> plain-text
       (partition-by identity)
       (mapcat (juxt count first))
       (filter (partial not= 1))
       (apply str)))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (->> cipher-text
       (re-seq #"\d*(?i)[a-z ]")
       (mapcat #(->> %1
                     ((juxt get-quantity get-letter))
                     (apply repeat)))
       (apply str)))
