module DNA
  ( nucleotideCounts
  , Nucleotide(..)
  ) where

import           Data.Map  (Map, alter, fromList)
import           Text.Read (Read, readMaybe)

data Nucleotide
  = A
  | C
  | G
  | T
  deriving (Eq, Ord, Show, Read)

base :: Map Nucleotide Int
base = fromList [(A, 0), (C, 0), (G, 0), (T, 0)]

toNucleotide :: Char -> Maybe Nucleotide
toNucleotide c = readMaybe [c]

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs =
  let nucs = mapM toNucleotide xs
   in maybe (Left xs) (Right . foldl (flip . alter . fmap $ succ) base) nucs
