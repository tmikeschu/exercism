(ns phone-number)

(def with-default (fnil identity ["000" "000" "0000"]))

(defn number- [num-string]
  (with-default
    (some->> num-string
             (re-find #"^1?\(?(\d{3})\)?[-. ]?(\d{3})[-. ]?(\d{4})$")
             rest)))

(defn number [num-string]
  (->> num-string
       number-
       (apply str)))

(defn area-code [num-string]
  (->> num-string
       number-
       first))

(defn pretty-print [num-string]
  (->> num-string
       number-
       ((fn [[a b c]] (apply str "(" a ") " b "-" c)))))
