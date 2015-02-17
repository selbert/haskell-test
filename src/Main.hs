-- | Main entry point to the application.
module Main where

import Control.Concurrent
-- | The main entry point.
main :: IO ()
main = do
    forkIO $ do
        a <- getLine
        putStrLn a
    putStrLn "Have a good day!"
