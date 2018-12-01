module Triangle exposing (Triangle(..), triangleKind)

import Set exposing (fromList, toList)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    let
        sides =
            [ x, y, z ]
    in
    case List.filter ((<) 0) sides of
        [ _, _, _ ] ->
            if x + y < z || x + z < y || z + y < x then
                Err "Violates inequality"

            else
                Ok (classifyValidSides sides)

        _ ->
            Err "Invalid lengths"


classifyValidSides : List number -> Triangle
classifyValidSides sides =
    let
        uniq =
            Set.fromList >> Set.toList
    in
    case uniq sides of
        [ _ ] ->
            Equilateral

        [ _, _ ] ->
            Isosceles

        _ ->
            Scalene
