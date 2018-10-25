module Anagram (anagramsFor) where
import Data.List (sort)
import Data.Char (toLower)
import Data.Set (fromList)
import Control.Applicative (liftA2)

isAnagram :: String -> String -> Bool
isAnagram xs = (liftA2 (&&) sameLetters notSameWord) . bothToLower
  where
    bothToLower = (map . map) toLower . (:[xs])
    allSame = (== 1) . length . fromList
    notSameWord = not . allSame 
    sameLetters = allSame . map sort 

anagramsFor :: String -> [String] -> [String]
anagramsFor = filter . isAnagram
