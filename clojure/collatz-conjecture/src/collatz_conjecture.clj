(ns collatz-conjecture)

(def half #(/ % 2))
(def triple #(* 3 %))

(defn- even-odd-transform
  [x]
  ((if (even? x) half (comp inc triple)) x))

(defn collatz
  ([num] (if (>= 1) (collatz num 0) (throw (Exception. "sorry"))))
  ([num steps]
   (if (= 1 num)
     steps
     (collatz (even-odd-transform num) (inc steps)))))
