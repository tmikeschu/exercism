module Bob (responseFor) where
import Data.Char (isSpace, toUpper)
import Text.Regex.Posix

data Utterance = QuestionShout
               | Question
               | Shout
               | Silence
               | None

hasLetters :: String -> Bool
hasLetters s = s =~ "[a-zA-Z]"

isQuestion :: String -> Bool
isQuestion s =
    case reverse s of
      '?':_ -> True
      _ -> False

isShout :: String -> Bool
isShout s = hasLetters s && s == map toUpper s 

isSilence :: String -> Bool
isSilence "" = True
isSilence _ = False

classify :: String -> Utterance
classify s 
    | isQuestion s' && isShout s' = QuestionShout
    | isQuestion s' = Question
    | isShout s = Shout
    | isSilence s' = Silence
    | otherwise = None
  where 
    trim = reverse . dropWhile isSpace . reverse . dropWhile isSpace
    s' = trim s


responseFor :: String -> String
responseFor [] = "Fine. Be that way!"
responseFor xs = case classify xs of
    QuestionShout -> "Calm down, I know what I'm doing!"
    Question -> "Sure."
    Shout -> "Whoa, chill out!"
    Silence -> "Fine. Be that way!"
    None -> "Whatever."
