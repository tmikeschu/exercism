module Leap exposing (isLeapYear)


isLeapYear : Int -> Bool
isLeapYear year =
    let
        yearDivBy x =
            modBy x year == 0
    in
    yearDivBy 4 && ((not << yearDivBy) 100 || yearDivBy 400)
