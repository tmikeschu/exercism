module Triangle exposing (Triangle(..), triangleKind)

import Set exposing (fromList, toList)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    if x <= 0 || y <= 0 || z <= 0 then
        Err "Invalid lengths"

    else if x + y < z || x + z < y || z + y < x then
        Err "Violates inequality"

    else
        Ok (classifyValidSides x y z)


classifyValidSides : number -> number -> number -> Triangle
classifyValidSides x y z =
    let
        numberOfDistinctValues =
            Set.fromList >> Set.toList >> List.length
    in
    case numberOfDistinctValues [ x, y, z ] of
        1 ->
            Equilateral

        2 ->
            Isosceles

        _ ->
            Scalene
