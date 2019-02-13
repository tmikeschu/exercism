module Accumulate exposing (accumulate)


accumulate : (a -> b) -> List a -> List b
accumulate func input =
    case input of
        [] ->
            []

        _ ->
            accumulateTR func input []


accumulateTR : (a -> b) -> List a -> List b -> List b
accumulateTR f xs ys =
    case xs of
        [] ->
            List.reverse ys

        y :: rest ->
            accumulateTR f rest (f y :: ys)
