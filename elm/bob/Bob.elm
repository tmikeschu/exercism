module Bob exposing (hey)

import List exposing (all, map)
import Regex exposing (contains, regex)
import String exposing (endsWith, isEmpty, toUpper, trim)


has_letters : String -> Bool
has_letters =
    contains (regex "[a-zA-Z]")


is_shouting : String -> Bool
is_shouting s =
    (&&) (has_letters s) ((==) (toUpper s) s)


is_question : String -> Bool
is_question =
    endsWith "?"


is_silent : String -> Bool
is_silent =
    trim >> isEmpty


apply : a -> (a -> b) -> b
apply x f =
    f x


hey : String -> String
hey remark =
    case [ is_shouting, is_question, is_silent ] |> map (apply remark) of
        [ True, True, False ] ->
            "Calm down, I know what I'm doing!"

        [ True, False, False ] ->
            "Whoa, chill out!"

        [ False, True, False ] ->
            "Sure."

        [ False, False, True ] ->
            "Fine. Be that way!"

        _ ->
            "Whatever."
