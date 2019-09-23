-- 1
f :: [Int] -> [Int]
f [x] = []
-- a
-- f (x:y:ys) 
--     | x == y = x : f (y:ys)
--     | otherwise = f (y:ys)

-- b
f (h:hs) = [x | (x, y) <- zip (h:hs) hs, y == x]

-- 2
-- Passar com filter, para filtrar apenas os elementos que estão entre 0 e 100
isInRange :: Int -> Bool
isInRange x = 0 <= x && x <= 100

-- isEven vai servir para passar num map, para transformar um array de Int em um array de Bool
isEven :: Int -> Bool
isEven n = (n `mod` 2) == 0

g :: [Int] -> Bool
g xs = foldr (&&) True (map isEven (filter isInRange xs))

-- 3
type Fabricante = String
type Potencia = Float
data Lampada = Compacta Fabricante Potencia
                | Incand Fabricante Potencia

instance Show Lampada where
    show (Compacta f p) = "Compacta " ++ f ++ " " ++ show p
    show (Incand i h) = "Incand " ++ i ++ " " ++ show h

instance Eq Lampada where
    (Compacta f1 p1) == (Compacta f2 p2) = f1 == f2 && p1 == p2
    (Incand i1 h1) == (Incand i2 h2) = i1 == i2 && h1 == h2
    _ == _ = False -- Nos outros casos será false