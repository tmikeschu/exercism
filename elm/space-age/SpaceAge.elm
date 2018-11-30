module SpaceAge exposing (Planet(..), ageOn)


ageOn : Planet -> Second -> Second
ageOn planet seconds =
    seconds / orbitalPeriod planet


type Planet
    = Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Uranus
    | Neptune


type alias Second =
    Float


earthSecondsInYear : Second
earthSecondsInYear =
    31557600


orbitalPeriod : Planet -> Second
orbitalPeriod planet =
    earthSecondsInYear
        * (case planet of
            Earth ->
                1

            Mercury ->
                0.2408467

            Venus ->
                0.61519726

            Mars ->
                1.8808158

            Jupiter ->
                11.862615

            Saturn ->
                29.447498

            Uranus ->
                84.016846

            Neptune ->
                164.79132
          )
