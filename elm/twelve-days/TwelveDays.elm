module TwelveDays exposing (recite)


zipWith : (a -> b -> c) -> List a -> List b -> List c
zipWith zipper xs ys =
    case ( xs, ys ) of
        ( [], _ ) ->
            []

        ( _, [] ) ->
            []

        ( x :: tx, y :: ty ) ->
            zipper x y :: zipWith zipper tx ty


daysGifts : List ( String, String )
daysGifts =
    [ ( "first", "a Partridge in a Pear Tree." )
    , ( "second", "two Turtle Doves, and " )
    , ( "third", "three French Hens, " )
    , ( "fourth", "four Calling Birds, " )
    , ( "fifth", "five Gold Rings, " )
    , ( "sixth", "six Geese-a-Laying, " )
    , ( "seventh", "seven Swans-a-Swimming, " )
    , ( "eighth", "eight Maids-a-Milking, " )
    , ( "ninth", "nine Ladies Dancing, " )
    , ( "tenth", "ten Lords-a-Leaping, " )
    , ( "eleventh", "eleven Pipers Piping, " )
    , ( "twelfth", "twelve Drummers Drumming, " )
    ]


days : Int -> Int -> List String
days offset stop =
    daysGifts
        |> List.map Tuple.first
        |> List.drop offset
        |> List.take (stop - offset)
        |> List.map onTheNthDay


gifts : Int -> List String
gifts offset =
    let
        giftReducer el acc =
            case acc of
                [] ->
                    el :: acc

                h :: t ->
                    (el ++ h) :: h :: t
    in
    daysGifts
        |> List.map Tuple.second
        |> List.foldl giftReducer []
        |> List.reverse
        |> List.drop offset


recite : Int -> Int -> List String
recite start stop =
    let
        offset =
            start - 1
    in
    zipWith (++) (days offset stop) (gifts offset)


onTheNthDay : String -> String
onTheNthDay whichDay =
    "On the " ++ whichDay ++ " day of Christmas my true love gave to me, "
