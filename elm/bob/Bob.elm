module Bob exposing (hey)

import Regex exposing (contains, regex)
import String exposing (endsWith, isEmpty, toUpper, trim)


hey : String -> String
hey remark =
    case classifyRemark remark of
        Just ShoutingQuesiton ->
            "Calm down, I know what I'm doing!"

        Just Shout ->
            "Whoa, chill out!"

        Just Question ->
            "Sure."

        Just Silent ->
            "Fine. Be that way!"

        Nothing ->
            "Whatever."


type Remark
    = ShoutingQuesiton
    | Shout
    | Question
    | Silent


classifications : List ( Remark, StringPred )
classifications =
    [ ( ShoutingQuesiton, isShoutingQuestion )
    , ( Shout, isShouting )
    , ( Question, isQuestion )
    , ( Silent, isSilent )
    ]


classifyRemark : String -> Maybe Remark
classifyRemark s =
    classifications
        |> List.filter (Tuple.second >> (|>) s)
        |> List.head
        |> Maybe.map Tuple.first


type alias StringPred =
    String -> Bool


hasLetters : StringPred
hasLetters =
    contains (regex "[a-zA-Z]")


isShouting : StringPred
isShouting s =
    hasLetters s && (toUpper s == s)


isQuestion : StringPred
isQuestion =
    endsWith "?"


isShoutingQuestion : StringPred
isShoutingQuestion s =
    isShouting s && isQuestion s


isSilent : StringPred
isSilent =
    trim >> isEmpty
