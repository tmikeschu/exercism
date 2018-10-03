module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn planet seconds = case planet of
  Mercury -> convert 0.2408467
  Venus -> convert 0.61519726
  Earth -> convert 1
  Mars -> convert 1.8808158
  Jupiter -> convert 11.862615
  Saturn -> convert 29.447498
  Uranus -> convert 84.016846
  Neptune -> convert 164.79132

  where earthSecondsTimes = (*) 31557600
        secondsOver = (/) seconds
        convert = secondsOver . earthSecondsTimes
