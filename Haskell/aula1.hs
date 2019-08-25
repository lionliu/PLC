-- sumSquares recebe 2 inteiros e retorna um inteiro
sumSquares :: Int -> Int -> Int
sumSquares x y = quad x + quad y
  -- Definicao local da funcao quad com um where
  where
    quad n = n * n

-- Com let in você retorna um valor
-- let possui definições
-- in tem uma expressão com as definições do let
sumSquares2 :: Int -> Int -> Int
sumSquares2 x y = let quadX = x * x
                      quadY = y * y
                      in quadX + quadY

eXor :: Bool -> Bool -> Bool
eXor x y = (x || y) && not (x && y)

vendas 0 = 2
vendas 1 = 4
vendas 2 = 5
vendas 3 = 7

vendasNulas :: Int -> Bool
vendasNulas 0 = vendas 0 == 0
vendasNulas n = (vendas n == 0) || vendasNulas (n-1)

--fromEnum recebe um char e retorna o valor na tabela ascii desse chr

offset :: Int 
offset :: fromEnum 'A' - fromEnum 'a'

-- toEnum recebe um inteiro e retorna um char equivalente
toUpper :: Char -> Char
toUpper ch = toEnum(fromEnum ch + offset)

-- Operador de concatenacao de string/list : ++ . Funciona pois string é tratado como uma lista
-- show retorna o que recebe em uma string
-- read recebe uma string e retorna um valor dele, seja booleano ou inteiro ou ...

-- Retorna n espaços
addEspacos :: Int -> String
addEspacos 0 = " "
addEspacos n = " " ++ addEspacos (n - 1)

paraDireita :: Int -> String -> String
paraDireita n str = addEspacos n ++ str


-- terminar em casa:
imprimiTotal :: Int -> String



-- Tuplas:

addPair :: (Int, Int) -> Int
-- addPair (x, y) = x + y
addPair p = fst p + snd p -- fst retorna o primeiro elemento da tupla, e snd o segundo



