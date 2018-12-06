(ns anagram
  (:require 
    [clojure.string :refer [lower-case]]))

(defn anagrams-for [word prospect-list]
  (let [word' (lower-case word)
        same-letters (comp (partial = (sort word')) sort)
        not-same-word (partial not= word')
        is-anagram #(->> %
                         lower-case
                         ((juxt same-letters not-same-word))
                         (every? true?))]
    (filter is-anagram prospect-list)))
