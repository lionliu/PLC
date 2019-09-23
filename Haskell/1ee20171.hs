-- 1
--b


-- 2
-- Já fiz em outra lista

-- 3
-- a
data Pilha t = Floor | Elem t (Pilha t) deriving (Show)

-- b
push :: Pilha t -> t -> Pilha t
push p a = Elem a p

pop :: Pilha t -> Pilha t
pop Floor = Floor
pop (Elem a b) = b

-- 4
-- a
data BTree = NullNode | Node Int BTree BTree

-- b
insert :: BTree -> Int -> BTree
insert NullNode n = Node n NullNode NullNode
insert (Node val tree1 tree2) n
    | n > val = insert tree2 n
    | otherwise = insert tree1 n

arvLista :: BTree -> [Int]
arvLista NullNode = []
arvLista (Node val tree1 tree2) = [val] ++ (arvLista tree1) ++ (arvLista tree2)

somaArv :: BTree -> Int
somaArv NullNode = 0
somaArv (Node val tree1 tree2) = val + (somaArv tree1) + (somaArv tree2)

listArv :: [Int] -> BTree
listArv (x:[]) = Node x NullNode NullNode
listArv (x:y:[])
        | x > y = Node x (listArv [y]) NullNode
        | otherwise = Node x NullNode (listArv [y])
listArv (x:y:ys)
        | x > y = Node x (listArv (y:ys)) NullNode
        | otherwise = Node x NullNode (listArv (y:ys))