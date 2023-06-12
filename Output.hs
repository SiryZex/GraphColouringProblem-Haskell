module Output
( saveGraph
, saveToTextFile 
) where

import System.IO
import DataStructure

saveGraph :: String -> Graph -> IO ()
saveGraph strFileName recGraph = saveToTextFile strFileName strContents
    where
        strContents = show recGraph

saveToTextFile :: String -> String -> IO ()
saveToTextFile strFileName strContents = do
    hndFile <- openFile strFileName WriteMode
    hPutStr hndFile strContents
    hClose hndFile