-- 1
-- É a 2 da lista 1
sublistas :: [a] -> [[a]]
sublistas [] = [[]]
sublistas (x:xs) = [x:ys | ys <- sublistas xs] ++ sublistas xs

-- 2
-- data Pilha t = Int t (Pilha t) | Nil deriving (Show)
isOddGreater :: [Int] -> Bool
isOddGreater l = (sum (filter odd l)) > (sum (filter even l)) 

isOddGreaterFilter :: [[Int]] -> [[Int]]
isOddGreaterFilter [] = []
isOddGreaterFilter (x:xs)
    | isOddGreater x = x: isOddGreaterFilter xs
    | otherwise = isOddGreaterFilter xs
 
filtrarEInserir :: [[Int]] -> Int -> ([[Int]], Int)
filtrarEInserir l n = (l1 , n * m)
    where 
        l1 = isOddGreaterFilter l
        m = maximum (map product l1)

-- 3
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap f g [] = []
altMap f g [a] = [f a]
altMap f g (x:y:ys) = [f x] ++ [g y] ++ (altMap f g ys)
--5

data Mobile = Pendente Int | Barra Mobile Mobile

-- a
peso :: Mobile -> Int 
peso (Pendente n) = n
peso (Barra m1 m2) = (peso m1) + (peso m2)

-- b
balanceado :: Mobile -> Bool
balanceado (Pendente _) = True
balanceado (Barra m1 m2) = (peso m1) == (peso m2) && (balanceado m1) && (balanceado m2)

