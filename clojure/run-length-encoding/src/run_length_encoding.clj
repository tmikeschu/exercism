(ns run-length-encoding)
(require '[clojure.string :as string])

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (string/replace
    plain-text
    #"(.)\1+"
    (fn [[total, unit]]
      (str (count total) unit))))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (string/replace
    cipher-text
    #"(\d+)(\D)"
    (fn [[_, a, b]]
      (->> b
           (repeat (Integer. a))
           (apply str)))))
