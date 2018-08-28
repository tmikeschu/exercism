module Bob exposing (hey)

import List exposing (all, map)
import Regex exposing (contains, regex)
import String exposing (endsWith, isEmpty, toUpper, trim)


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


isSilent : StringPred
isSilent =
    trim >> isEmpty


hey : String -> String
hey remark =
    let
        fact =
            all ((|>) remark)
    in
    if fact [ isShouting, isQuestion ] then
        "Calm down, I know what I'm doing!"

    else if fact [ isShouting ] then
        "Whoa, chill out!"

    else if fact [ isQuestion ] then
        "Sure."

    else if fact [ isSilent ] then
        "Fine. Be that way!"

    else
        "Whatever."
