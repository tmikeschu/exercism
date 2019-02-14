module GradeSchool exposing (addStudent, allStudents, empty, studentsInGrade)

import Dict exposing (Dict)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Int (List Student)


empty : School
empty =
    Dict.empty


addOrCreate : Student -> Maybe (List Student) -> Maybe (List Student)
addOrCreate student =
    Just << (::) student << Maybe.withDefault []


addStudent : Grade -> Student -> School -> School
addStudent grade =
    Dict.update grade << addOrCreate


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade =
    List.sort
        << Maybe.withDefault []
        << Dict.get grade


allStudents : School -> List ( Grade, List Student )
allStudents =
    Dict.toList
