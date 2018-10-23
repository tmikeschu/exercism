module Bob (responseFor) where
import Data.Char (isSpace, isUpper, isAlpha)
import Control.Applicative (liftA2)
import Data.List (isSuffixOf)

type Predicate a = a -> Bool

(<&&>) :: Applicative f => f Bool -> f Bool -> f Bool
(<&&>) = liftA2 (&&)

data Utterance = QuestionShout
               | Question
               | Shout
               | Silence
               | None

isQuestion :: Predicate String
isQuestion = isSuffixOf "?"

isShout :: Predicate String
isShout =
    (any isAlpha) <&&> (all isUpper . filter isAlpha)

isQuestionShout :: Predicate String
isQuestionShout = isQuestion <&&> isShout

classify :: String -> Utterance
classify s
    | isQuestionShout s' = QuestionShout
    | isQuestion s' = Question
    | isShout s' = Shout
    | null s' = Silence
    | otherwise = None
  where 
    s' = filter (not . isSpace) s

responseFor :: String -> String
responseFor =
    response . classify
  where
    response QuestionShout = "Calm down, I know what I'm doing!"
    response Question = "Sure."
    response Shout = "Whoa, chill out!"
    response Silence = "Fine. Be that way!"
    response None = "Whatever."
