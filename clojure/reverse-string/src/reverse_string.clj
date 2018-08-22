(ns reverse-string)

(def reverse-string (comp
                      (partial apply str)
                      (partial reduce #(cons %2 %1) (list))))
