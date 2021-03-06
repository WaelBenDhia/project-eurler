module Level2.Problem26
  ( problem
  ) where

import Problem

problem :: Problem Integer
problem = Problem 26 "Reciprocal cycles" (toInteger $ longestCycleLenUnder 1000)

longestCycleLenUnder :: Int -> Int
longestCycleLenUnder n =
  fst $
  foldl compareT (0, 0) $
  filter (not . isTerminating . fst) $ zip range (map cycleLen range)
  where
    compareT x y
      | snd x > snd y = x
      | otherwise = y
    range = [2 .. n - 1]

cycleLen :: Integral a => a -> Int
cycleLen n =
  if isTerminating n
    then 0
    else length $ cycle n [1]
  where
    cycle d c =
      if newRem `elem` c
        then newRem : takeWhile (/= newRem) c
        else cycle d (newRem : c)
      where
        newRem = rem (head c * 10) d

isTerminating :: Integral a => a -> Bool
isTerminating n
  | n == 1 = True
  | rem n 2 == 0 = isTerminating (quot n 2)
  | rem n 5 == 0 = isTerminating (quot n 5)
  | otherwise = False
