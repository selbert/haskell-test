module Main where

import           Control.Concurrent
import           Control.Monad.Reader

type Bus = ReaderT (Chan String) IO

main :: IO ()
main = do
    chan <- newChan
    runReaderT run chan

run :: Bus ()
run = do
    readConsoleInput
    printOutputToConsole

readConsoleInput :: Bus ()
readConsoleInput = do
    chan <- ask
    _ <- io $ forkIO $ forever $ do
        line <- getLine
        writeChan chan line
    io $ return ()

printOutputToConsole :: Bus ()
printOutputToConsole = do
    chan <- ask
    io $ do
        line <- readChan chan
        putStrLn $ generateAnswer line
    printOutputToConsole

generateAnswer:: String -> String
generateAnswer line =
    let splittedLine = words line in
        case (head splittedLine) of
            "sono" -> "si"
            "culo" -> "merda"
            _ -> line

io :: IO a -> Bus a
io = liftIO