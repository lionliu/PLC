-- Listas só podem armazenar elementos de um tipo
-- String, assim como em c, é uma lista de caracteres.
-- [] é uma lista vazia, de tipo generico
-- temos uma função : definida por (:) :: a -> [a] => [a] que constroi listas,sempre recebendo o parametro mais a diretia sendo uma lista
-- É tipo um append que insere na cabeça da lista
-- Ex: 1 : [2] cria uma lista [1,2]
-- Outra maneira diferente: 1 : 2 : []

-- [1..10] vai gerar uma lista com 1, e incremata o item por 1 até 10
-- [x , y .. z] vai começar com x, e vai incrementando y - x até o limite de z, podendo ser < y para ficar em ordem decrescente

somaLista :: [Int] -> Int
somaLista [] = 0-- Caso base vai retornar um elemento neutro
somaLista (x:xs) = x + somaLista xs -- Caso recursivo

{-
  somaLista [1, 2, 3]
  = somaLista (1: (2: (3: [])))
  = 1 + somaLista (2: (3: []))
  = 1 + 2 somaLista (3: [])
  = 1 + 2 + 3 somaLista []
  = 1 + 2 + 3 + 0
  = 6
-}

-- Dobrar elementos de uma lista
double :: [Int] -> [Int]
double [] = []
double (x:xs) = (x * 2) : double xs

-- Retornar se um inteiro está na lista
member :: [Int] -> Int -> Bool
member [] n = False
member (x:xs) n = (x==n)||member xs n

-- filtrar número de uma lista
digit :: Char -> Bool
digit ch = ('0' <= ch) && (ch <= '9')

digits :: String -> String
digits [] = []
digits (x:xs) 
 | digit x = x : digits xs
 | otherwise = digits xs

--Somar uma lista de pares
sumPairs :: [(Int, Int)] -> [Int]
sumPairs [] = []
sumPairs ((x,z):xs) = (x+z): sumPairs xs

-- Tamanho da lista, equivale a função length
listSize :: [Int] -> Int
listSize [] = 0
listSize (x:xs) = 1 + listSize xs

-- Reverter lista
revertList :: [Int] -> [Int]
revertList [] = []
revertList (x:xs) = revertList xs ++ [x] -- ++ é o operador de concatenacao de lista, deve ser utilizada quando não se pode utilizar o :

repetition :: Int -> Char -> [Char]
repetition 0 ch = []
repetition n ch = repetition (n-1) ch ++ [ch]

-- Implementacao da funcao take, que retira os n ultimos elementos da lista
mtake _ [] = []
mtake 0 _ = []
mtake n (x:xs) = x : mtake (n - 1) xs

-- Implementacao da funcao drop, que retira os n primeiros elementos da lista
mdrop _ [] = []
mdrop 0 a = a
mdrop n (x:xs)= mdrop (n-1) xs

-- InsertiontSort
iSort :: [Int] -> [Int]
iSort [] = []
iSort (cabeca:cauda) = ins cabeca (iSort cauda)

isn :: Int -> [Int] -> [Int]
ins x [] = [x]
ins x (y : ys) 
    | x <= y = x:(y:ys)
    | otherwise = y : ins x ys

-- Uso de case (expressão) of
head1 :: [a] -> a
head1 xs = case xs of
    [] -> error "Lista vazia"
    (x:_) -> x

howsTheList :: [a] -> String
howsTheList xs = "Uma lista" ++ case xs of
    [] -> "vazia"
    [x] -> "com um elemento"
    (x:xs) -> "com vários elementos"

-- takeWhile

-- fazer as questões de banco de dados do slide