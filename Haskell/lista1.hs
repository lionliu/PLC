-- 2
subListas :: [a] ->[[a]]
subListas [] = [[]]
subListas (x:xs) = [x:ys | ys <- subListas xs] ++ subListas xs

-- 3

-- a
poli :: Int -> Int -> Int -> Int -> Int
poli a b c = (\x -> a * x * x + b * x + c)

-- b
listaPoli :: [(Int, Int, Int)] -> [Int -> Int]
listaPoli l = [poli a b c | (a, b, c) <- l]

-- Outra maneira:
-- listaPoli [] = []
-- listaPoli ((a, b, c):xs) = poli a b c : listaPoli xs

-- c
appListaPoli :: [Int -> Int] -> [Int] -> [Int]
appListaPoli lFuncoes lInt = [f x | f <- lFuncoes, x <- lInt]
-- Outra maneira:
-- appListaPoli [] _ = []
-- appListaPoli (f:fs) (x:xs) = f a : appListaPoli fs xs

-- 7
type Codigo = Int
data Candidato = Presidente Codigo | Senador Codigo | Deputado Codigo | Branco 

type Urna = [Candidato]
type Apuracao = [(Candidato, Int)]

urna = []

totalVotos :: Urna -> Candidato -> Int
totalVotos u c = length (filter (\x -> x == c) u)

apurar :: Urna -> Apuracao
apurar [] = []
apurar 

