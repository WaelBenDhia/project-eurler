module Level1.Problem17
  ( problem
  ) where

import Data.List

import Problem

problem :: Problem Integer
problem =
  Problem
    17
    "Number letter counts"
    (fromIntegral $ countAllNumbersIn [1 .. 1000])

countAllNumbersIn :: [Integer] -> Int
countAllNumbersIn = length . concatMap nameNumber

nameNumber :: (Show t, Integral t) => t -> String
nameNumber n =
  intercalate "and" $
  filter
    (/= "")
    [ if t > 0
        then nameDigit t ++ "thousand"
        else ""
    , if h > 0
        then nameDigit h ++ "hundred"
        else ""
    , nameNumberBelowHundred underH
    ]
  where
    underH = rem n 100
    h = rem (quot n 100) 10
    t = quot n 1000

nameNumberBelowHundred :: (Show a, Integral a) => a -> String
nameNumberBelowHundred n
  | n < 10 = nameDigit n
  | n < 20 = nameTeens n
  | otherwise = nameDecs (quot n 10) ++ nameDigit (rem n 10)

nameDigit :: (Eq a, Num a, Show a) => a -> String
nameDigit 0 = ""
nameDigit 1 = "one"
nameDigit 2 = "two"
nameDigit 3 = "three"
nameDigit 4 = "four"
nameDigit 5 = "five"
nameDigit 6 = "six"
nameDigit 7 = "seven"
nameDigit 8 = "eight"
nameDigit 9 = "nine"
nameDigit x = error "cannot name " ++ show x ++ " with nameDigit"

nameTeens :: (Eq a, Num a, Show a) => a -> String
nameTeens 10 = "ten"
nameTeens 11 = "eleven"
nameTeens 12 = "twelve"
nameTeens 13 = "thriteen"
nameTeens 14 = "fourteen"
nameTeens 15 = "fifteen"
nameTeens 16 = "sixteen"
nameTeens 17 = "seventeen"
nameTeens 18 = "eighteen"
nameTeens 19 = "nineteen"
nameTeens x = error "cannot name " ++ show x ++ " with nameTeens"

nameDecs :: (Eq a, Num a, Show a) => a -> String
nameDecs 2 = "twenty"
nameDecs 3 = "thirty"
nameDecs 4 = "forty"
nameDecs 5 = "fifty"
nameDecs 6 = "sixty"
nameDecs 7 = "seventy"
nameDecs 8 = "eighty"
nameDecs 9 = "ninety"
nameDecs x = error "cannot name " ++ show x ++ " with nameDecs"
