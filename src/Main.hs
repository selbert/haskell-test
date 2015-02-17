module Main where

import Control.Concurrent

main :: IO ()
main = do
    forkIO $ do
        a <- getLine
        putStrLn a
    putStrLn "Have a good day!"
