module Pangram (isPangram) where
import Data.Char (isAlpha, toLower)
import Data.List (sort, nub)

isPangram :: String -> Bool
isPangram =
    let hasAllLetters = (== ['a'..'z'])
    in hasAllLetters . sort . nub . map toLower . filter isAlpha
