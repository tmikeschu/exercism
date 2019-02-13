module Anagram exposing (detect)


detect : String -> List String -> List String
detect word =
    List.filter (isAnagram word)


isAnagram : String -> String -> Bool
isAnagram a b =
    let
        a1 =
            String.toLower a

        b1 =
            String.toLower b
    in
    a1 /= b1 && sameLetters a1 b1


sameLetters : String -> String -> Bool
sameLetters a b =
    sortedLetters a == sortedLetters b


sortedLetters : String -> List Char
sortedLetters =
    String.toList >> List.sort
