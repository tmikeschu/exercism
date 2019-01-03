(ns say
  (:require
    [clojure.string :as string]))

(def digit-maps
  [{:base ""}
   {:base "one"}
   {:base "two" :tens "twen"}
   {:base "three" :tens "thir"}
   {:base "four" :tens "for" :teen "four"}
   {:base "five" :tens "fif"}
   {:base "six"}
   {:base "seven"}
   {:base "eight" :tens "eigh"}
   {:base "nine"}])

(defn to-digits
  "Returns a list of individual digits"
  [x]
  (-> (str x)
      (string/split #"")
      ((partial map #(Integer. %)))))

(defn- to-digit-map [num]
  (-> num
      (drop digit-maps)
      first))

(defn- first-valid-key [ks]
  (comp first
        (partial remove empty?)
        (apply juxt ks)))

(defn- check-tens [x]
  (-> x
      to-digit-map
      ((first-valid-key [:tens :base]))))

(defn- when-pos [f]
  #(when (pos? %) (f %)))

; Used to map/zip place-value triplets (hundreds,thousands,etc)
(def place-functions
  [(comp :base to-digit-map)

   (when-pos
     (comp #(str % "ty") check-tens))

   (when-pos
     (comp
       #(str % " hundred")
       :base
       to-digit-map))])

(defn- get-teen-prefix [x]
  (->> (filter #(= (:base %1) x) digit-maps)
       first
       ((first-valid-key [:teen :tens :base]))))

(defn- to-teen [base] 
  (let  [weirdos {"" (constantly "ten")
                  "one" (constantly "eleven")
                  "two" (constantly "twelve") }]
    (-> base
        ((or
           (weirdos base)
           (comp #(str % "teen") get-teen-prefix))))))

(defn- place-value [s] 
  #(when-not (empty? %) (str % " " s)))

; List used to map/zip apply functions to corresponding indexed values.
; E.g., maps '('twenty' 'seventeen') to '('twenty' 'seventeen thousand')
(def place-value-appenders
  (->> '("thousand" "million" "billion")
       (map place-value)
       (cons identity)))

(defn translate-triplet
  "Translates up to three digits to english. E.g., 101 -> one hundred one"
  [x]
  (-> x
      ((partial map #(%1 %2) place-functions))
      ((partial remove empty?))
      reverse
      ((partial string/join " "))
      (string/replace #"ty " "ty-")
      (string/replace #"onety-?(.*)" (comp to-teen last))
      (string/replace #"-$" "")))

(defn number 
  "Returns a string of the english form of a numerical input"
  [num]
  (cond
    (neg? num)
    (throw (IllegalArgumentException. "negatives not allowed"))

    (> num 999999999999)
    (throw (IllegalArgumentException. "number over 999999999999 not allowed"))

    (zero? num)
    "zero"

    :else
    (->> num
         to-digits
         reverse
         (partition 3 3 [])
         (map translate-triplet)
         (map #(%1 %2) place-value-appenders)
         (remove empty?)
         reverse
         (string/join " "))))
