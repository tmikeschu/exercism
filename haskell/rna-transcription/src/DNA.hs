module DNA
  ( toRNA
  ) where

import           Data.Map (Map)
import qualified Data.Map as Map

complements :: Map Char Char
complements = Map.fromList [('C', 'G'), ('G', 'C'), ('T', 'A'), ('A', 'U')]

eitherLookup :: Ord k => k -> Map k a -> Either k a
eitherLookup k m =
  case Map.lookup k m of
    Nothing -> Left k
    Just v  -> Right v

toRNA :: String -> Either Char String
toRNA = mapM (`eitherLookup` complements)
