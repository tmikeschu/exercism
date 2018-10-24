module Acronym (abbreviate) where
import Text.Regex (splitRegex, mkRegex)
import Data.Char (toUpper, isUpper, isLower)

toLetter :: String -> String
toLetter "" = ""
toLetter s@(h:t)
    | all isUpper s = h':[]
    | any isUpper t = h':(toLetter . filter isUpper $ t)
    | otherwise = h':[]
  where
    h' = toUpper h

abbreviate :: String -> String
abbreviate = 
    let boundary = mkRegex "[, \\-]"
    in concatMap toLetter . splitRegex boundary
