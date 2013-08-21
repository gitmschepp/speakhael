{- LANGUAGE: haskell, AUTHOR: J. Michael Scheppat,
 - DEPENDENCIES: espeak,paplay
 - see LICENSE file for the licence if this script
-}
module Main
    where

import System.IO
import System.Cmd
 
-- REPL
repl :: String -> (String -> IO()) -> IO ()
repl prompt f =
    do
        putStr prompt
        hFlush stdout
        expr <- getLine
        case (length expr) of
            0 -> repl prompt f
            _ -> execute expr
                    where
                        execute str
                            | str == exitCmd = putStrLn $ abschied
                            | str == altExitCmd = putStrLn $ abschied 
                            | otherwise = do  
                                {- Uncomment these lines in exchange if you dont want to use paplay  -}
                                --  _ <- system $ "espeak -v de+m4 -s 120 \"" ++ str ++ "\""
                                -- f str

                                -- _ <- system $ "espeak -v de+m4 -s 120 \"" ++ str ++ "\"" ++ " --stdout|paplay"
                                _ <- system $ "espeak -v en+m4 -s 120 \"" ++ str ++ "\"" ++ " --stdout|paplay"
                                repl prompt f
                                    

 
exitCmd :: String
exitCmd = ":x"
altExitCmd :: String
altExitCmd = ":q"

abschied :: String
abschied = "Goodbye!"

greeting :: String
greeting = "Welcome! This is Speakhael, a simple espeak shell written in haskell.\n Type the words you would like to have read aloud and hit Enter to confirm.\n Or type \"" ++ exitCmd ++  "\" followed by Enter to leave. -- v1.02"

main = do 
    putStrLn $greeting 
    putStrLn $ ("Type " ++ exitCmd ++ " to quit ")
    repl "Texteingabe>" putStrLn
-- end of file
