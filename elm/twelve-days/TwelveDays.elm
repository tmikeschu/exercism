module TwelveDays exposing (recite)


type alias Day =
    ( Int, DayInfo )


type alias DayInfo =
    { order : String, quantity : String, gift : String, after : Maybe String }


days : List DayInfo
days =
    [ DayInfo "first" "a" "Partridge in a Pear Tree" (Just ".")
    , DayInfo "second" "two" "Turtle Doves" (Just ", and ")
    , DayInfo "third" "three" "French Hens" Nothing
    , DayInfo "fourth" "four" "Calling Birds" Nothing
    , DayInfo "fifth" "five" "Gold Rings" Nothing
    , DayInfo "sixth" "six" "Geese-a-Laying" Nothing
    , DayInfo "seventh" "seven" "Swans-a-Swimming" Nothing
    , DayInfo "eighth" "eight" "Maids-a-Milking" Nothing
    , DayInfo "ninth" "nine" "Ladies Dancing" Nothing
    , DayInfo "tenth" "ten" "Lords-a-Leaping" Nothing
    , DayInfo "eleventh" "eleven" "Pipers Piping" Nothing
    , DayInfo "twelfth" "twelve" "Drummers Drumming" Nothing
    ]


recite : Int -> Int -> List String
recite start stop =
    List.range start stop
        |> List.map toDay
        |> List.map makeVerse


toDay : Int -> Maybe Day
toDay x =
    days
        |> List.take x
        |> List.reverse
        |> List.head
        |> Maybe.map (\t -> ( x, t ))


makeVerse : Maybe Day -> String
makeVerse day =
    [ partOne, partTwo ]
        |> List.map ((|>) day)
        |> List.foldr (++) ""


partOne : Maybe Day -> String
partOne =
    Maybe.map
        (\( _, { order } ) ->
            "On the " ++ order ++ " day of Christmas my true love gave to me, "
        )
        >> Maybe.withDefault ""


partTwo : Maybe Day -> String
partTwo =
    Maybe.map
        (\( num, { quantity, gift, after } ) ->
            quantity
                ++ " "
                ++ gift
                ++ Maybe.withDefault ", " after
                ++ partTwo (toDay (num - 1))
        )
        >> Maybe.withDefault ""
