module Main where

import Control.Monad
import Problem
import Solutions
import System.TimeIt
import Text.Read

main :: IO ()
main = do
  putStrLn $
    concat
      [ "\nWelcome to this little CLI that prints out solutions to Project "
      , "Euler problems\n"
      , "\nIf a problem isn't solved it'll tell you so, if it doesn't then "
      , "eventually it will output the result.\n"
      , "\nSome of these are pretty slow and may take a while (up to 3 minutes "
      , "in the worst case) to terminate.\n"
      ]
  problemSelection

problemSelection :: IO ()
problemSelection = do
  num <- promptInt "\nSelect a problem or 0 to quit"
  when (num /= 0) $ do
    timeIt $ putStrLn $ prettyPrint $ getProblem num
    problemSelection

always :: t1 -> t -> t1
always a _ = a

retry :: IO b -> IO b
retry a = putStrLn "Could not parse input:" >>= always a

promptLine :: String -> IO String
promptLine prompt = putStrLn prompt >>= always getLine

promptInt :: String -> IO Int
promptInt prompt =
  promptLine prompt >>= (maybe (retry $ promptInt prompt) return . readMaybe)
