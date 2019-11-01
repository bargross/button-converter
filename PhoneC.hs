module PhoneC where

import Data.Char
import Data.List

type Digit = Char
type Press = Int

data Button = Button {
                     press :: Digit,
                     digits :: String
                    } deriving (Eq, Ord, Show)

data Phone = Phone [Button] deriving (Eq, Ord, Show)

button1 = Button '1' "1"
button2 = Button '2' "abc2"
button3 = Button '3' "def3"
button4 = Button '4' "ghi4"
button5 = Button '5' "jkl5"
button6 = Button '6' "mno6"
button7 = Button '7' "pqrs7"
button8 = Button '8' "tuv8"
button9 = Button '9' "wxyz9"
button10 = Button '*' "*^"
button11 = Button '0' "0+ "
button12 = Button '#' ".,"

keypad = Phone [button1,
                button2,
                button3,
                button4,
                button5,
                button6,
                button7,
                button8,
                button9,
                button11,
                button12
                ]

unbox :: Maybe a -> a
unbox (Just a) = a

-- Simple algorithm (function) to turn Char from lower case to upper and viseversa
lowOrUp :: Digit -> Digit
lowOrUp x
        | x `elem` ['a'..'z'] = chr (ord x - 32)
        | otherwise = chr (ord x + 32)

conv :: Button -> String
conv (Button a b) = b

--convert Char to relative button press
search :: Digit -> (Digit, Press)
search x = let fm ch (Phone (x':xs))
                    | ch `elem` (conv x') =
                      (press x', (+1) $ unbox $ elemIndex ch (conv x'))
                    | otherwise = fm ch (Phone xs)
           in fm x keypad

--converts Char depending on whether is a capital or not
getPress :: Digit -> Either (Digit, Press) [(Digit, Press)]
getPress x = let check y
                        | y `elem` (['a'..'z'] ++ ['0'..'9'] ++ "*^ +.,") = Left $ search y
                        | y `elem` ['A'..'Z'] = Right $ [('*', snd . search $ lowOrUp y), search . lowOrUp $ y]
                 in check x

--convert list of strings to button presses for each
convToPress :: [String] -> [[Either (Digit, Press) [(Digit, Press)]]]
convToPress [] = []
convToPress (x: xs) = getall x : convToPress xs
  where
    getall [] = []
    getall (x:xs) = [getPress x] ++ getall xs

--retrieve character
get :: (Digit, Press) -> Digit
get ks = let check (a, b) (Phone (x:xs))
                        | a == (press x) = (digits x) !! (b - 1)
                        | otherwise = check (a, b) (Phone xs)
              in check ks keypad

-- This function gets the tuple of a list of tuples determining whether is a capital letter or not
getchar :: Either (Digit, Press) [(Digit, Press)] -> Digit
getchar (Left a) = get a
getchar (Right [a, b]) = lowOrUp $ get b

convToChar :: [[Either (Digit, Press) [(Digit, Press)]]] -> [String]
convToChar [] = []
convToChar (x:xs) = let getc [] = []
                        getc (x':xs') = [getchar x'] ++ getc xs'
                    in getc x : convToChar xs

