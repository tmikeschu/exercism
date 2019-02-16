module Raindrops exposing (raindrops)


raindrops : Int -> String
raindrops number =
    case toRainSounds number of
        [] ->
            String.fromInt number

        sounds ->
            String.join "" sounds


toRainSounds : Int -> List String
toRainSounds number =
    let
        isDivisibleBy x =
            modBy x number == 0
    in
    [ ( 3, "Pling" ), ( 5, "Plang" ), ( 7, "Plong" ) ]
        |> List.filter (Tuple.first >> isDivisibleBy)
        |> List.map Tuple.second
