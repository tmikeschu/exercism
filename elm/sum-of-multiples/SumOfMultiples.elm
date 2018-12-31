module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples multiples limit =
    let
        isValid x y =
            modBy y x == 0
    in
    limit
        - 1
        |> List.range 1
        |> List.filter (\x -> List.any (isValid x) multiples)
        |> List.foldl (+) 0
