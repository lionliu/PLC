-- O deriving Show é necessario para que WenDu seja impresso como resposta de alguma função
data WenDu = Re | Leng deriving (Show)
data Season = Haru | Natsu | Aki | Fuyu
data XingQi = I | Er | San | Si | Wu | Liu | Ri

climate :: Season -> WenDu
climate Fuyu = Leng
climate _ = Re

type Nome = String
type Idade = Int
data Pessoas = Pessoa Nome Idade

showPerson :: Pessoas -> String
showPerson (Pessoa n i) = n ++ "--" ++ show i

data Figura = Circulo Float
            | Retangulo Float Float
-- Quando data tem parametros, deve ser passado com parenteses
area :: Figura -> Float
area (Circulo r) = pi * r * r
area (Retangulo a b) = a * b

circular :: Figura -> Bool
circular (Circulo _) = True
circular _ = False

-- tipo algebrico recursivo
data Expr = Lit Int
        | Add Expr Expr
        | Sub Expr Expr

eval :: Expr -> Int
eval (Lit n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2

exibirExpr :: Expr -> String
exibirExpr (Lit n) = show n
exibirExpr (Add e1 e2) = exibirExpr e1 ++ " + " ++ exibirExpr e2
exibirExpr (Sub e1 e2) = exibirExpr e1 ++ " - " ++ exibirExpr e2

-- Linked List
data Lista = Nil | Cons Int Lista deriving (Show)

somaLista :: Lista -> Int
somaLista Nil = 0
somaLista (Cons n l) = n + somaLista l

-- Arvore de inteiros
data Tree = NilT | Node Int Tree Tree deriving (Show)

sumTree :: Tree -> Int
sumTree NilT = 0;
sumTree (Node val treeA treeB) = val + sumTree treeA + sumTree treeB

maxi :: Int -> Int -> Int
maxi x y 
    | x >= y = x
    | otherwise = y

profundidade :: Tree -> Int
profundidade NilT = 0
profundidade (Node _ ta tb) = 1 + maxi (profundidade ta) (profundidade tb)

collapse :: Tree -> [Int]
collapse NilT = []
collapse (Node val ta tb) = collapse ta ++ [val] ++ collapse tb

-- Polimorfismo
-- t funciona como um generics do Java.
data ListaPoli t = NilAt | ConsT t (ListaPoli t) deriving (Show)

toList :: ListaPoli t -> [t]
toList NilAt = []
toList (ConsT n l) = toList l ++ [n]

fromList :: [t] -> ListaPoli t
fromList [] = NilAt
fromList (x:xs) = (ConsT x (fromList xs))