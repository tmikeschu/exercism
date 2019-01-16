(ns say
  (:require
    [clojure.string :as string]
    [clojure.pprint :refer [cl-format]]))

(defn number 
  "Returns a string of the english form of a numerical input"
  [num]
  (cond
    (neg? num)
    (throw (IllegalArgumentException. "negatives not allowed"))

    (> num 999999999999)
    (throw (IllegalArgumentException. "number over 999999999999 not allowed"))

    :else
    (-> num
        ((partial cl-format nil "~R"))
        (string/replace #"," ""))))
