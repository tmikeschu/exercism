module CollatzConjecture (collatz) where
import Data.List (findIndex)

collatz :: Integer -> Maybe Integer
collatz x
  | x <= 0 = Nothing
  | otherwise = fmap toInteger . findIndex (== 1) . (iterate collatz') $ x

collatz' :: Integer -> Integer
collatz' x
    | even x = x `div` 2
    | otherwise = x * 3 + 1
