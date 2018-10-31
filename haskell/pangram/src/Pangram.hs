module Pangram (isPangram) where
import Data.Char (isAlpha, toLower)
import Data.List (sort, nub)
import qualified Data.Set as S

isPangram :: String -> Bool
isPangram =
    let 
      hasAllLetters = (== ['a'..'z'])
      uniq = S.toList . S.fromList
    in hasAllLetters . sort . uniq . map toLower . filter isAlpha
