(ns isbn-verifier
  [:require [clojure.string :as string]])

(def isbn-slots
  "This matcher captures each digit in the isbn format"
  #"^\d{9}[\dX]$")

(defn isbn? [isbn]
  "Determines if isbn string is valid."
  (true?
    (some->> (string/replace isbn #"-" "")
             (re-find isbn-slots)
             (replace {\X 10})
             (map-indexed #(->> %2
                                str
                                Integer.
                                (* (- 10 %1))))
             (reduce +)
             (#(rem % 11))
             zero?)))
