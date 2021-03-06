module LeapYear (isLeapYear) where

isDivisibleBy :: Integer -> Integer -> Bool
isDivisibleBy a b = a `mod` b == 0

isLeapYear :: Integer -> Bool
isLeapYear year
  | year `isDivisibleBy` 400 = True
  | year `isDivisibleBy` 100 = False
  | year `isDivisibleBy` 4 = True
  | otherwise = False
