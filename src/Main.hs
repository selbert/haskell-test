module Main where

import           Control.Concurrent

main :: IO ()
main = do
    chan <- newChan
    _ <- forkIO $ readConsoleInput chan
    printOutputToConsole chan
    return ()

readConsoleInput :: Chan String -> IO ()
readConsoleInput chan = do
    _ <- forkIO $ forever $ do
        line <- getLine
        writeChan chan line
    return ()
    where
        forever a = a >> forever a

printOutputToConsole :: Chan String -> IO ()
printOutputToConsole chan = do
    line <- readChan chan
    putStrLn line
    printOutputToConsole chan