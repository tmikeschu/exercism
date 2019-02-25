module DNA
  ( toRNA
  ) where

import qualified Data.Either as Either
import qualified Data.Map    as Map

complements :: Map.Map Char Char
complements = Map.fromList [('C', 'G'), ('G', 'C'), ('T', 'A'), ('A', 'U')]

eitherLookup :: Ord k => k -> Map.Map k a -> Either k a
eitherLookup k m =
  case Map.lookup k m of
    Nothing -> Left k
    Just v  -> Right v

toRNA :: String -> Either Char String
toRNA xs =
  let partition' = Either.partitionEithers . map (`eitherLookup` complements)
   in case partition' xs of
        ([], r)  -> Right r
        (l:_, _) -> Left l
