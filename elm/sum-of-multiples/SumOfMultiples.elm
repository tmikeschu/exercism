module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples multiples limit =
    let
        isValid x y =
            modBy y x == 0
    in
    List.range 1 (limit - 1)
        |> List.filter (\x -> List.any (isValid x) multiples)
        |> List.sum
