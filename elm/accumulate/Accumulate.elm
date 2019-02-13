module Accumulate exposing (accumulate)


accumulate : (a -> b) -> List a -> List b
accumulate =
    accumulateTR []


accumulateTR : List b -> (a -> b) -> List a -> List b
accumulateTR ys f xs =
    case xs of
        [] ->
            List.reverse ys

        y :: rest ->
            accumulateTR (f y :: ys) f rest
