module DifferenceOfSquares exposing (difference, squareOfSum, sumOfSquares)

import List as L


sq : Int -> Int
sq x =
    x ^ 2


oneTo =
    L.range 1


squareOfSum : Int -> Int
squareOfSum =
    oneTo >> L.sum >> sq


sumOfSquares : Int -> Int
sumOfSquares =
    oneTo >> L.map sq >> L.sum


difference : Int -> Int
difference =
    (|>)
        >> L.map
        >> (|>) [ squareOfSum, sumOfSquares ]
        >> L.foldr (-) 0
