(ns beer-song
  (:require [clojure.string :refer [capitalize join]]))

(defn- bottles [n]
  (let [edge-cases ["no more bottles" "1 bottle"]
        default (str n " bottles")]
    (get edge-cases n default)))

(defn- of-beer [b]
  (str b " of beer.\n"))

(defn- on-the-wall
  ([b]
   (on-the-wall b ", "))
  ([b end]
   (str b " of beer on the wall" end)))

(defn- pass-it [s]
  (str "Take " s " down and pass it around, "))

(defn- take-down [n]
  (let [edge-cases [["Go to the store and buy some more, " 99]
                    [(pass-it "it") 0]]
        default [(pass-it "one") (dec n)]]
    (->> (get edge-cases n default)
         ((fn [[a b]]
            (str
              a
              (on-the-wall (bottles b) ".\n")))))))

(defn verse
  "Returns the nth verse of the song."
  [n]
  (->> n
       ((juxt (comp capitalize on-the-wall bottles)
              (comp of-beer bottles)
              take-down))
       (apply str)))

(defn sing
  "Given a start and an optional end, returns all verses in this interval. If
  end is not given, the whole song from start is sung."
  ([start] (sing start 0))
  ([start end]
   (->> (range end (inc start))
        reverse
        (map verse)
        (join "\n"))))
