(ns flatten-array)

(defn flatten
  ([arr]
   ;; conditional
   ; (let [pass (fn [a _] a)]
   ;   (reduce
   ;     #((cond (coll? %2) flatten
   ;             (nil? %2) pass
   ;             :else conj)
   ;       %1 %2)
   ;     []
   ;     arr)))
  ;; no conditional
  (let [resolvers { clojure.lang.PersistentVector flatten
                   nil (fn [a _] a)}
        reducer (fn [acc el]
                  ((get resolvers (type el) conj) acc el))]
    (reduce reducer [] arr)))
  ([a b]
   (->> b
        flatten
        (concat a)
        (into []))))
