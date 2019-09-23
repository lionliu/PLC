-- São funções que recebem outras funções como parametro

soma3Int :: Int -> (Int -> (Int -> Int))
soma3Int x y z = x + y + z

aplica2x :: (t -> t) -> t -> t 
aplica2x f x = f (f x)

inc :: Int -> Int
inc x = x + 1

dec :: Int -> Int
dec x = x - 1
-- Usando em aplica2x: aplica2x inc 2

-- zeroInRange retorna true se alguma resposta da função entre 0 e n resultar 0
zeroInRange :: (Int -> Int) -> Int -> Bool
zeroInRange f 0 = (f 0 == 0)
zeroInRange f n = zeroInRange f (n-1) || (f n == 0)

isCrescent :: (Int -> Int) -> Int -> Bool
isCrescent f 0 = True
isCrescent f n = isCrescent f (n-1) && (f n >= f (n - 1))

-- Alta ordem com listas

dobrarValLista :: [Int] -> [Int]
dobrarValLista [] = []
dobrarValLista (x:xs) = (x * 2) : dobrarValLista xs

quadradoValLista :: [Int] -> [Int]
quadradoValLista [] = []
quadradoValLista (x:xs) = (x * x) : quadradoValLista xs

-- recebe uma funcao que recebe int e retorna int e uma lista de int
mapeamento :: (Int -> Int) -> [Int] -> [Int]
mapeamento f [] = []
mapeamento f (x:xs) = (f x) : mapeamento f xs

isPair :: Int -> Bool
isPair x = mod x 2 == 0

mapIsPair :: [Int] -> [Bool]
mapIsPair [] = []
mapIsPair (x:xs) = isPair x : mapIsPair xs

mapProp :: (a -> b) -> [a] -> [b]
mapProp f [] = []
mapProp f (x:xs) = f x : mapProp f xs

-- fazer funcao isCrescent do slide

mapCL f l = [f x | x <- l]

filtro :: (a -> Bool) -> [a] -> [a]
filtro f [] = []
filtro f (x:xs) 
    | f x = x : filtro f xs
    | otherwise = filtro f xs


filtroCL f l = [x | x <- l, f x]

-- fold pela direita
mfoldr :: (t -> t -> t) -> t -> [t] -> t
mfoldr f v [] = v
mfoldr f v (x:xs) = f x (mfoldr f v xs)

{-
mfoldr (||) False [True, False] =
    (||) True (mfoldr (||) False [False]) =
        (||) True ((||) False (mfoldr (||) False [])) =
            (||) True ((||) False False) =
                (||) True False =
                    True
-}

-- fold pela esquerda
mfoldl :: (t -> t -> t) -> t -> [t] -> t
mfoldl f v [] = v
mfoldl f v (x:xs) = mfoldl f (f v x) xs

{-
mfoldl (&&) False [True, False] =
    mfoldl (&&) ((&&) False True) [False] =
        mfoldl ((&&) False False) [] = 
            (((&&) False False)) = 
                False
-}

somaQuadradoItens :: [Int] -> Int
somaQuadradoItens l = foldr (+) 0 (map (^2) l)

largest :: [Int] -> Int -> Int
largest [] a = a
largest (x:xs) a
    | x > a = largest xs x
    | otherwise = largest xs a

largest2 :: [Int] -> Int
largest2 l = largest l (-10000000000) 

maiores :: [[Int]] -> [Int]
-- maiores l = map largest2 l
maiores l = map maximum l