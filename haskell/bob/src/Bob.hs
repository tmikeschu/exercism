module Bob (responseFor) where
import Data.Char (isSpace, isUpper, isAlpha)
import Control.Applicative (liftA2)
import Data.List (find, isSuffixOf)

data Utterance = QuestionShout
               | Question
               | Shout
               | Silence
               | None

type StringTest = String -> Bool

isQuestion :: StringTest
isQuestion "" = False
isQuestion s = "?" `isSuffixOf` s

isShout :: StringTest
isShout =
    liftA2 (&&) (any isAlpha) (all isUpper . filter isAlpha)

isQuestionShout :: StringTest
isQuestionShout = liftA2 (&&) isQuestion isShout

trim :: String -> String
trim =
    let doTwice f = (!! 2) . iterate f
    in doTwice (reverse . dropWhile isSpace)

classify :: String -> Utterance
classify s =
    getUtterance $ find match classifiers
  where 
    getUtterance = maybe None snd
    match = ($ (trim s)) . fst
    classifiers = [ (isQuestionShout, QuestionShout)
                  , (isQuestion, Question)
                  , (isShout, Shout)
                  , (null, Silence)
                  ]

responseFor :: String -> String
responseFor xs =
    case classify xs of
        QuestionShout -> "Calm down, I know what I'm doing!"
        Question -> "Sure."
        Shout -> "Whoa, chill out!"
        Silence -> "Fine. Be that way!"
        None -> "Whatever."
