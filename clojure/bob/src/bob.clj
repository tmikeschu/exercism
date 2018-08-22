(ns bob
  (:use [clojure.string :only (ends-with? upper-case trim)]))

(def responses {
                #{:question} "Sure."
                #{:shout :question} "Calm down, I know what I'm doing!"
                #{:shout} "Whoa, chill out!"
                #{:silent} "Fine. Be that way!"
                #{} "Whatever." })

(defn- has-letters? [s] (not (empty? (re-find #"[a-zA-Z]" s))))
(defn- is-upper-case? [s] (apply = ((juxt identity upper-case) s)))

(defn- shout [s] (when ((every-pred has-letters? is-upper-case?) s) :shout))
(defn- question [s] (when (ends-with? s "?") :question))
(defn- silent [s] (when (empty? s) :silent))
(def map-labels (juxt question shout silent))
(defn- get-label [s] (->> s map-labels (remove nil?)))

(defn response-for [s]
  (->> s
       trim
       (get-label)
       (reduce conj #{})
       (get responses)))
