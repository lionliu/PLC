-- Lazy evaluation: a avaliacao de uma expressao so é realizada quando seu valor for necessario

f1 :: Int -> Int -> Int
f1 a b = a + 12

g :: Int -> Int
g c = c + g c

-- Se for chamado f1 n (g 1), não entrara em loop, pois o segundo parametro nao é utilizado.

fk :: [Int] -> [Int] -> Int
fk (x:xs) (y:ys) = x + y
-- Se for passado fk [1..] [10..] não entrará em loop, pois apenas a cabeça é utilizada, não a cauda.

-- Chamadas/recursão de cauda sao chamadas cujo resultado é diretamente retornado por quem faz a chamada

-- Fatorial de cima p/ baixo
fat n = tailFat n 1
tailFat 0 x = x
tailFat n x = tailFat (n-1) (n*x)
-- Evita overflow

