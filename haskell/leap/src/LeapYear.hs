module LeapYear (isLeapYear) where

divBy :: Integer -> Integer -> Bool
divBy a b = a `mod` b == 0

isLeapYear :: Integer -> Bool
isLeapYear year = yearDivBy 4 && (not (yearDivBy 100) || yearDivBy 400)
  where yearDivBy = divBy year
