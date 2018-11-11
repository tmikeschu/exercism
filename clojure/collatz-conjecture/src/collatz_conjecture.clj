(ns collatz-conjecture)

(defn ** [x n] (reduce * (repeat n x)))

(defn- transform [x]
  (let [rem-two (rem x 2)]
    (-> x
        (/ (- 2 rem-two))
        (* (** 3 rem-two))
        (+ rem-two))))

(defn collatz [num]
  (if (<= num 0)
    (throw (Exception. "sorry"))
    (count (take-while #(> % 1) (iterate transform num)))))
