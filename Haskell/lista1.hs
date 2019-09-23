--1
-- Funciona, tendo como definição map . (.) :: (b -> c) -> [a -> b] -> [a -> c]
-- Ela recebe uma função b -> c e uma lista com funções [a -> b] e se aplica em todas as funções nessa lista a primeira função, retornado um lista de funções passando pela primeira função.

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

--4
--a
isMatrixSquareAux :: [[Int]] -> Int -> Bool
isMatrixSquareAux [] n = True
isMatrixSquareAux (x:xs) n = (length x) == n && isMatrixSquareAux xs n

isMatrixSquare :: [[Int]] -> Bool
isMatrixSquare (x:xs) = isMatrixSquareAux (x:xs) (length x)
--b



--5
-- Verifica se a soma dos impares é maior
isOddSumBigger :: [Int] -> Bool
isOddSumBigger l 
        | (sum (filter odd l)) > (sum (filter even l)) = True
        | otherwise = False   

-- Fiz meu próprio filter pq o filter do haskell não tava ajudando.
isOddSumBiggerFilter :: [[Int]] -> [[Int]]
isOddSumBiggerFilter [] = []
isOddSumBiggerFilter (x:xs)
        | isOddSumBigger x = x : isOddSumBiggerFilter xs
        | otherwise = isOddSumBiggerFilter xs

getMaxSum :: [[Int]] -> Int -> Int
getMaxSum [] n = n
getMaxSum (x:xs) n
        | (sum x) > n = getMaxSum xs (sum x)
        | otherwise = getMaxSum xs n

filtrarEInserir :: [[Int]] -> Int -> ([[Int]], Int)
filtrarEInserir l i = (isOddSumBiggerFilter l, (getMaxSum (isOddSumBiggerFilter l) 0) * i)

--6
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
-- altMap f1 f2 [] = []
-- altMap f1 f2 (x:xs) 
--         | null xs = [f1 x]
--         | otherwise = [f1 x, f2 (head xs)] ++ altMap f1 f2 (drop 1 xs)
altMap f1 f2 (x:[]) = [f1 x]
altMap f1 f2 (x:y:[]) = [f1 x, f2 y]
altMap f1 f2 (x:y:ys) = [f1 x, f2 y] ++ altMap f1 f2 ys

-- 7
type Codigo = Int
data Voto = Presidente Codigo | Senador Codigo | Deputado Codigo | Branco deriving (Show)

type Urna = [Voto]
type Apuracao = [(Voto, Int)]

urna = [(Presidente 17), (Presidente 13), (Presidente 18), (Presidente 17), (Senador 300), (Senador 666), (Senador 300), (Deputado 1717), (Deputado 1717), (Deputado 5050)]
--a 
instance Eq Voto where
    (Presidente a) == (Presidente b) = a == b
    (Senador a) == (Senador b) = a == b
    (Deputado a) == (Deputado b) = a == b
    _ == _ = False

--b
totalVotos :: Urna -> Voto -> Int
-- totalVotos vai primeiro filtrar na Urna só o para que seja retornado uma urna só com o candidato recebido
totalVotos u c = length (filter (\x -> x == c) u)

so1Candidato :: Urna -> Urna
so1Candidato [] = []
so1Candidato (x:xs)
        | elem x xs = so1Candidato xs
        | otherwise = x : so1Candidato xs

apurar :: Urna -> Apuracao
apurar u = [(c, v) | c <- (so1Candidato u), let v = totalVotos u c]
-- apurar [] = []
-- apurar (u:us) = (u, totalVotos (u:us) u) : apurar (filter (\x -> x /= u) us)

