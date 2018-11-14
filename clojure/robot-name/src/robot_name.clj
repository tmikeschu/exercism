(ns robot-name)

(defn- rand-letters [n]
  (let [letters (->> (range 65 91) (map char) (apply str))]
    (take n (repeatedly #(rand-nth letters)))))
(defn- rand-numbers [n] (take n (repeatedly #(rand-int 9))))

(defn- rand-name []
  (apply str (concat (rand-letters 2) (rand-numbers 3))))

(defn- valid-name [existing]
  (->> (repeatedly rand-name)
       (drop-while (partial contains? existing))
       first))

(def robots (atom #{}))

(defn- create-name []
  (->> (valid-name @robots)
       ((fn [n] do (swap! robots conj n) n))))

(defn robot [] (atom {:name (create-name)}))
(defn robot-name [r] (:name @r))
(defn reset-name [r] (swap! r assoc :name (create-name)))
