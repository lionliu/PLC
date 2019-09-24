data Graph t = Nil | Node t [Graph t] deriving (Show)

dfs :: (Eq t) => Graph t -> t -> Bool
dfs Nil n = False
dfs (Node x g) n = (doDfs n [(Node x g)] [x])

doDfs :: (Eq t) => t -> [Graph] -> [t] -> Bool
doDfs n [] _ = False -- Se todos os nós foram visitados, a pilha está vazia, logo o valor não foi encontrado
doDfs n ((Node x g):gs) visited 
        | n == x = True
        | otherwise = (doDfs n (stack ++ gs) (x:visited)) 
            where stack = [(Node v ad) | (Node v ad) <- g, (filter (== v) visited) == []]