module Triangle (rows) where
import Data.Function ((&))

mirror :: (([a] -> [a]) -> [a]) -> [[a]]
mirror = (flip map) [id, reverse]

rows :: Int -> [[Integer]]
rows x
    | x <= 0 = []
    | otherwise = take x $ iterate stackedSum init
  where
    init = [1]
    stackedSum = foldl1 (zipWith (+)) .
               mirror .
               (&) .
               (0:)
