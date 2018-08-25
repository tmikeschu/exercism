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
    let
        fact xs =
            xs |> map (apply remark) |> all identity
    in
    if fact [ is_shouting, is_question ] then
        "Calm down, I know what I'm doing!"

    else if fact [ is_shouting ] then
        "Whoa, chill out!"

    else if fact [ is_question ] then
        "Sure."

    else if fact [ is_silent ] then
        "Fine. Be that way!"

    else
        "Whatever."
