module DataStructure
( Node(..)
, Link(..)
, Graph(..)
) where

type Node = String
data Link = Link { source :: Node
                 , dest :: Node
                 } deriving (Read, Show)
data Graph = Graph [Link] | EmptyGraph deriving (Read, Show)