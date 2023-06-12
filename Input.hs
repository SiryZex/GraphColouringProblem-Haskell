module Input
(
  loadGraph
) where

import System.IO
import DataStructure

loadGraph :: String -> IO Graph
loadGraph strFileName = do
    hndFile <- openFile strFileName ReadMode
    strGraph <- hGetContents hndFile
    let recGraph = read strGraph :: Graph
    putStrLn $ "Loaded: " ++ strGraph
    hClose hndFile
    return recGraph