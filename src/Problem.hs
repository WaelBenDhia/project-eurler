module Problem
  ( Problem(..)
  , prettyPrint
  ) where

data Problem a = Problem
  { ind :: Int
  , name :: String
  , solution :: a
  } deriving (Show)

prettyPrint :: Show a => Problem a -> String
prettyPrint p =
  "Problem " ++
  show (ind p) ++ ": " ++ name p ++ "\nAnswer: " ++ show (solution p)
