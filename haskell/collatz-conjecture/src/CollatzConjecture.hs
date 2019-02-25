module CollatzConjecture (collatz) where
import Data.List (elemIndex)

collatz :: Integer -> Maybe Integer
collatz x
  | x <= 0 = Nothing
  | otherwise = fmap toInteger . elemIndex 1 . iterate collatz' $ x

collatz' :: Integer -> Integer
collatz' x
    | even x = x `quot` 2
    | otherwise = x * 3 + 1
