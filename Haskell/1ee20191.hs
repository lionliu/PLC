-- 1 
-- vendas :: Int -> Int
vendas 0 = 3
vendas 1 = 8
vendas 2 = 0
vendas 3 = 5
vendas 4 = 0
vendas _ = 0

zeroVendas :: Int -> Int
-- a
-- zeroVendas n = length ([x | x <- [0..n], 0 == vendas x])
-- b
-- zeroVendas n = length (filter (==0) (map vendas [0..n]))
-- c
zeroVendas n = foldr (+) 0 (map mapZerotoOne (filter (==0) (map vendas [0..n])))
mapZerotoOne 0 = 1

-- 2
-- a
type Cidade = String
data ClasseTrem = Primeira | Segunda
data ClasseAv = Economica | Executiva
data Bilhete = Trem Cidade Cidade ClasseTrem | Onibus Cidade Cidade | Aviao Cidade Cidade ClasseAv 

-- b
type Viagem = [Bilhete]

valida :: Viagem -> Bool
valida [] = True
valida (x:[]) = True
-- Fazer todas os possibilidades abaixo
valida ((Trem o d c):(Trem o1 d1 c1):xs) = d == o1 && valida ((Trem o1 d1 c1):xs)
valida ((Trem o d c):(Onibus o1 d1):xs) = d == o1 && valida ((Onibus o1 d1):xs)
valida ((Trem o d c):(Aviao o1 d1 c1):xs) = d == o1 && valida ((Aviao o1 d1 c1):xs)
valida ((Aviao o d c):(Trem o1 d1 c1):xs) = d == o1 && valida ((Trem o1 d1 c1):xs)
valida ((Aviao o d c):(Aviao o1 d1 c1):xs) = d == o1 && valida ((Aviao o1 d1 c1):xs)
valida ((Aviao o d c):(Onibus o1 d1):xs) = d == o1 && valida ((Onibus o1 d1):xs)
valida ((Onibus o d):(Aviao o1 d1 c1):xs) = d == o1 && valida ((Aviao o1 d1 c1):xs)
valida ((Onibus o d):(Trem o1 d1 c1):xs) = d == o1 && valida ((Trem o1 d1 c1):xs)
valida ((Onibus o d):(Onibus o1 d1):xs) = d == o1 && valida ((Onibus o1 d1):xs)

-- 3
data Nat = Zero | Succ Nat deriving (Show)

-- a
intToNat :: Int -> Nat
intToNat 0 = Zero
intToNat n = Succ (intToNat (n - 1))

-- b
natToInt :: Nat -> Int
natToInt Zero = 0
natToInt (Succ x) = 1 + natToInt x

-- c
soma :: Nat -> Nat -> Nat
soma Zero Zero = Zero
soma Zero (Succ c) = (Succ c)
soma (Succ c) Zero = (Succ c)
soma (Succ c) (Succ d) = intToNat (x + y)
    where 
        x = (natToInt (Succ c))
        y = (natToInt (Succ d))

-- d
mult :: Nat -> Nat -> Nat
mult Zero Zero = Zero
mult Zero (Succ c) = Zero
mult (Succ c) Zero = Zero
mult (Succ c) (Succ d) = intToNat (x * y)
    where 
        x = (natToInt (Succ c))
        y = (natToInt (Succ d))