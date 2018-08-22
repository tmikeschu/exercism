(ns series)

(defn slices
  ([string length]
   (if (empty? string) [] (slices string length '()))
   )
  ([string length coll]
   (let [diff (- (count string) length)]
     (cond
       (zero? length) (conj coll "")
       (neg? diff) coll
       (zero? diff) (conj coll string)
       (pos? diff) (slices
                     (subs string 1)
                     length
                     (conj coll (subs string 0 length)))))))
