(ns word-count
  (:require [clojure.string :refer [lower-case]]))

(defn word-count [s]
  (->> s
       lower-case
       (re-seq #"\b\w+\b")
       frequencies))
