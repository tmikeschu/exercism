module DNA
  ( nucleotideCounts
  , Nucleotide(..)
  ) where

import           Data.List (foldl)
import           Data.Map  (Map, alter, fromList)

data Nucleotide
  = A
  | C
  | G
  | T
  deriving (Eq, Ord, Show)

base :: Map Nucleotide Int
base = fromList [(A, 0), (C, 0), (G, 0), (T, 0)]

toNucleotide :: Char -> Maybe Nucleotide
toNucleotide c =
  case c of
    'A' -> Just A
    'C' -> Just C
    'G' -> Just G
    'T' -> Just T
    _   -> Nothing

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs =
  case mapM toNucleotide xs of
    Nothing -> Left xs
    Just ns -> Right . foldl (flip . alter . fmap $ succ) base $ ns
