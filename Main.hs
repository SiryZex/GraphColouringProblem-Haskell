import DataStructure
import Input
import Output

import Process

main = do
    g <- loadGraph "Graph.txt"
    let strDot = toGraphVizDot g
    saveToTextFile "Graph.gv" strDot