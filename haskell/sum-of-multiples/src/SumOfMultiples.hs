module SumOfMultiples
  ( sumOfMultiples
  ) where

import qualified Data.List as List

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit =
  let validFactors = List.filter (0 /=) factors
   in List.sum $
      List.filter
        (\x -> List.any ((0 ==) . rem x) validFactors)
        [1 .. limit - 1]
