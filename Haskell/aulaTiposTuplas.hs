-- tipos

type Nome = String
type Idade = Int
type CPF = Int
type Pessoa = (Nome, Idade, CPF)

nome :: Pessoa -> String
nome (n, i, c) = n

menorMaior :: Int -> Int -> Int -> (Int, Int)
-- Retorna o menor e maior inteiros recebidos
menorMaior a b c 
    | (a > b && b > c) = (c, a)
    | (b > c && c > a) = (a, b)
    | (c > b && b > a) = (a, c)
    | (c > a && a > b) = (b, c)
    | (b > a && a > c) = (c, b)
    | (a > c && c > b) = (b, a)

ordenaTripla :: (Int, Int, Int) -> (Int, Int, Int)
-- retorna a tupla ordenada.
ordenaTripla (a, b, c) 
    | (a > b && b > c) = (c, b, a)
    | (b > c && c > a) = (a, c, b)
    | (c > b && b > a) = (a, b, c)
    | (c > a && a > b) = (b, a, c)
    | (b > a && a > c) = (c, a, b)
    | (a > c && c > b) = (b, c, a)