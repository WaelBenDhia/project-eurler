module Level2.Problem43
  ( problem
  ) where

import Problem

problem :: Problem Integer
problem =
  Problem
  { ind = 43
  , name = "Sub-string divisibility"
  , solution =
      sum $ map read $ pandigitalWithValidation "" $ map show [9,8 .. 0]
  }

pandigitalWithValidation :: [Char] -> [[Char]] -> [[Char]]
pandigitalWithValidation x l
  | length x > 0 && head x == '0' = []
  | length x == 4 && (not $ subDivisible (2, 4) 2 x) = []
  | length x == 5 && (not $ subDivisible (3, 5) 3 x) = []
  | length x == 6 && (not $ subDivisible (4, 6) 5 x) = []
  | length x == 7 && (not $ subDivisible (5, 7) 7 x) = []
  | length x == 8 && (not $ subDivisible (6, 8) 11 x) = []
  | length x == 9 && (not $ subDivisible (7, 9) 13 x) = []
  | length x == 10 =
    if subDivisible (8, 10) 17 x
      then [x]
      else []
  | otherwise =
    concatMap (\y -> pandigitalWithValidation (x ++ y) (filter (/= y) l)) l

numDigits :: Integer -> Int
numDigits = length . show

divisibleBy :: Integral a => a -> a -> Bool
divisibleBy x y = rem y x == 0

subList :: (Int, Int) -> [a] -> [a]
subList (s, e) = take (e - s + 1) . drop (s - 1)

subDivisible :: (Read a, Integral a) => (Int, Int) -> a -> [Char] -> Bool
subDivisible (s, e) d = divisibleBy d . read . subList (s, e)