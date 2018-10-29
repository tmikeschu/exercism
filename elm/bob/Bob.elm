module Bob exposing (hey)

import Char as C
import List as L
import Maybe as M
import String as S


type alias Predicate a =
    a -> Bool


type Utterance
    = ShoutingQuesiton
    | Shout
    | Question
    | Silent
    | None


hey : String -> String
hey =
    respond << classifyUtterance


respond : Utterance -> String
respond utterance =
    case utterance of
        ShoutingQuesiton ->
            "Calm down, I know what I'm doing!"

        Shout ->
            "Whoa, chill out!"

        Question ->
            "Sure."

        Silent ->
            "Fine. Be that way!"

        None ->
            "Whatever."


classifyUtterance : String -> Utterance
classifyUtterance s =
    let
        testPasses =
            Tuple.first >> (|>) s
    in
    classifications
        |> L.filter testPasses
        |> L.map Tuple.second
        |> L.head
        |> M.withDefault None


classifications : List ( Predicate String, Utterance )
classifications =
    let
        isSilent =
            S.trim >> S.isEmpty
    in
    [ ( isShoutingQuestion, ShoutingQuesiton )
    , ( isShouting, Shout )
    , ( isQuestion, Question )
    , ( isSilent, Silent )
    ]


isShoutingQuestion : Predicate String
isShoutingQuestion =
    applyTests L.all [ isShouting, isQuestion ]


isShouting : Predicate String
isShouting =
    let
        hasLetters =
            String.any C.isAlpha

        isUpper =
            String.all C.isUpper << String.filter C.isAlpha
    in
    applyTests L.all [ hasLetters, isUpper ]


isQuestion : Predicate String
isQuestion =
    S.endsWith "?"


applyTests : (((a -> b) -> b) -> a1 -> c) -> a1 -> a -> c
applyTests requirement tests subject =
    requirement ((|>) subject) tests
