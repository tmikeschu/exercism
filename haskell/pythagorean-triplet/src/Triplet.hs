module Triplet (isPythagorean, mkTriplet, pythagoreanTriplets) where

import Data.List (sort)

combos :: Int -> [a] -> [[a]]
combos 0 _ = [[]]
combos _ [] = []
combos n (x:xs) = (map (x:) (combos (n-1) xs)) ++ (combos n xs)

isPythagorean :: (Int, Int, Int) -> Bool
isPythagorean (a, b, c) = 
    let [a', b', c'] = map (^ 2) . sort $ [a, b, c]
    in a' + b' == c'

mkTriplet :: Int -> Int -> Int -> (Int, Int, Int)
mkTriplet a b c = (a,b,c)

pythagoreanTriplets :: Int -> Int -> [(Int, Int, Int)]
pythagoreanTriplets minFactor maxFactor =
    filter isPythagorean .
    map (\[a, b ,c] -> mkTriplet a b c) .
    combos 3 $
    [minFactor..maxFactor]
