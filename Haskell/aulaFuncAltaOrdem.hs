-- São funções que recebem outras funções como parametro

soma3Int :: Int -> (Int -> (Int -> Int))
soma3Int x y z = x + y + z

aplica2x :: (t -> t) -> t -> t 
aplica2x f x = f (f x)

inc :: Int -> Int
inc x = x + 1

-- Usando em aplica2x: aplica2x inc 2


-- total :: (Int -> Int) -> Int -> Int


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
    | f x = x : filtro xs
    | otherwise = filtro f xs


filtroCL f l = [x | x <- l, f x]

-- fold pela direita
mfoldr :: (t -> t -> t) -> t -> [t] -> t
mfoldr f v [] = v
mfoldr f v (x:xs) = f x (mfold f v xs)

{-
mfoldr (||) False [True, False] =
    (||) True (mfoldr (||) False [False]) =
        (||) True ((||) False (mfoldr (\\) False [])) =
            (\\) True ((||) False False) =
                (||) True False =
                    True
-}

-- fold pela esquerda
mfoldl :: (t -> t -> t) -> t -> [t] -> t
mfoldl f v [] = v
mfoldl f v (x:xs) = mfoldl f (f v x) xs

