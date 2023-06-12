module Process
( getEndpoints
, getNodes
, calcDegree
, calcDegrees
, findMostConstrained
, toGraphVizDot
) where

import DataStructure
import Data.Function
import Data.List

getEndpoints :: (Link -> Node) -> [Link] -> [Node]
getEndpoints _ [] = []
getEndpoints accessor (l:ls) = accessor l : getEndpoints accessor ls

getNodes :: Graph -> [Node]
getNodes EmptyGraph = []
getNodes (Graph []) = []
getNodes (Graph links) = nub nodesDup
    where nodesDup = sources ++ dests
          sources = getEndpoints source links
          dests = getEndpoints dest links

calcDegree :: Graph -> Node -> Int
calcDegree EmptyGraph _ = 0
calcDegree (Graph links) n = length sources + length dests
    where sources = isThisNode $ getEndpoints source links
          dests = isThisNode $ getEndpoints dest links
          isThisNode = filter (== n)


calcDegrees ::Graph -> [(Node, Int)]
calcDegrees EmptyGraph = []
calcDegrees (Graph []) = []
calcDegrees g = [(n, calcDegree g n) | n <- getNodes g]

findMostConstrained :: Graph -> [Node]
findMostConstrained EmptyGraph = []
findMostConstrained (Graph []) = []
findMostConstrained g = [n | (n, d) <- mostConstrained]
    where degrees = calcDegrees g
          maxDegree = snd $ maximumBy (compare `on` snd) degrees
          nodes = getNodes g
          mostConstrained = filter (\(n, d) -> d == maxDegree) degrees

toGraphVizDot :: Graph -> String
toGraphVizDot EmptyGraph = "graph G {}"
toGraphVizDot (Graph links) = 
    let
        linkToString l = src l ++ " -- " ++ dst l ++ ";"
        src l = show $ source l
        dst l = show $ dest l
        linksToString [] = ""
        linksToString (l:ls) = linkToString l ++ linksToString ls
        const = findMostConstrained $ Graph links
        spacedNodes = map (\n -> n ++ " ") const
        maxConst = foldr (++) "" spacedNodes
        doubleCircle = "node [shape = doublecircle];" ++ maxConst ++ ";"
        circle = "node [shape = circle];"
    in "graph G {" ++ doubleCircle ++ circle ++ linksToString links ++ "}"