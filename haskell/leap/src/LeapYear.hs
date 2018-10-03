module LeapYear (isLeapYear) where

isDivisibleBy :: Integer -> Integer -> Bool
isDivisibleBy a b = a `mod` b == 0

isLeapYear :: Integer -> Bool
isLeapYear year =
    year `isDivisibleBy` 4 &&
      (not (year `isDivisibleBy` 100) || year `isDivisibleBy` 400)
