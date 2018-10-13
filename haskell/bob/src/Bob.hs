module Bob (responseFor) where
import Data.Char (isSpace, toUpper)
import Text.Regex.Posix
import Control.Applicative (liftA2)
import Data.List (find)
import Data.Maybe (maybe, fromJust)

data Utterance = QuestionShout
               | Question
               | Shout
               | Silence
               | None

type StringTest = String -> Bool

isQuestion :: StringTest
isQuestion s =
    case reverse s of
        '?':_ -> True
        _ -> False

hasLetters :: StringTest
hasLetters = flip (=~) "[a-zA-Z]"

isUpper :: StringTest
isUpper = liftA2 (==) id (map toUpper)

isShout :: StringTest
isShout = liftA2 (&&) hasLetters isUpper

isQuestionShout :: StringTest
isQuestionShout = liftA2 (&&) isQuestion isShout

trim :: String -> String
trim s = iterate (reverse . dropWhile isSpace) s !! 2

classify :: String -> Utterance
classify s =
    maybe None snd .
    find (applyToStr . fst) $
    classifiers
  where 
    applyToStr = flip ($) . trim $ s
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
