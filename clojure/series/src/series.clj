(ns series)

(defn slices
  [string length]
   (if (= 0 length)
     [""]
     (->> string
          (iterate rest)
          (map #(->> %  (take length) (apply str)))
          (take-while #(= length (count %))))))
