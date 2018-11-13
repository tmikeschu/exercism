(ns isbn-verifier)

(def isbn-slots
  "This matcher captures each digit in the isbn format"
  #"^(\d)-?(\d)(\d)(\d)-?(\d)(\d)(\d)(\d)(\d)-?([\dX])$")

(defn isbn? [isbn]
  "Determines if isbn string is valid."
  (let [factors (reverse (range 1 11))]
    (true?
      (some->> isbn
               (re-find isbn-slots)
               rest
               (replace {"X" 10})
               (map #(Integer. %))
               (map * factors)
               (reduce +)
               (#(rem % 11))
               zero?))))
