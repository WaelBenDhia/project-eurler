module Level1.Problem9
  ( problem
  ) where

import Problem

problem :: Problem Integer
problem = Problem 9 "Special Pythagorean triplet" (solver 1000)

solver :: Integer -> Integer
solver t = a * b * c
  where
    (a, b, c) = head $ filter (checkSum t) $ triplets t

pyth :: Integer -> Integer -> Integer
pyth a b = wholeRoot (a ^ 2 + b ^ 2)

wholeRoot :: Integer -> Integer
wholeRoot x = truncate $ sqrt $ fromIntegral x

perfectSquare :: Integer -> Bool
perfectSquare x = x == wholeRoot (x ^ 2)

isTriplet :: (Integer, Integer) -> Bool
isTriplet (a, b) = a < b && perfectSquare c && (a ^ 2 + b ^ 2 == c ^ 2) && a < b
  where
    c = pyth a b

checkSum :: (Eq a, Num a) => a -> (a, a, a) -> Bool
checkSum t (a, b, c) = t == a + b + c

triplets :: Integer -> [(Integer, Integer, Integer)]
triplets bound =
  map (\(a, b) -> (a, b, pyth a b)) $
  filter isTriplet $ concatMap tuples [1 .. bound]
  where
    tuples x = map ((,) x) [x + 1 .. bound]
