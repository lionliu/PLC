-- É similar a interfaces em java

-- em memberList, ele recebe como entrada todo tipo t que é instancia da classe Eq, ou seja, pode ser comparada
memberList :: (Eq t) => [t] -> t -> Bool
memberList [] b = False
-- Pelo tipo t estar instanciado como a classe Eq, é possivel utilizar o operador ==
memberList (a:as) b = (a==b) || memberList as b

-- Conseguimos instancias num data via o deriving
data List t = Nil | Cons t (List t) deriving (Eq, Ord, Show)

-- Classes já implementadas do haskell:
-- Eq: operadores == e /=
-- Ord: operadores <, <=, >, >=, min, max e compare
-- Show: operador show
-- Foldable: operadores fold, foldr, foldl, lenght, concat

data Curso = Manha String | Tarde String
-- instance Classe Data where: Serve p/ implementar num data o que se espera da classe.
-- É como se a classe(data) que eu criei implementasse uma interface(classe)
instance Eq Curso where
        (Manha n1) == (Manha n2) = n1 == n2
        (Tarde n3) == (Tarde n4) = n3 == n4
        -- Se for chamado um (Manha "aa") == (Tarde "aa") vai levar uma exception, pois a definicao ainda não foi definida.
        -- Definindo a definicao
        _ == _ = False

-- Criando classe
-- Todos os tipos que serão instancias da classe Visivel terão uma implementação do toString e do size.
class Visivel t where
        toString :: t -> String
        size :: t -> Int

-- Exemplo de Bool instanciado com a classe Visivel
instance Visivel Bool where
    toString True = "True"
    toString False = "False"
    size _ = 1

-- Instancia de lista da classe Visible
instance Visivel a => Visivel [a] where
    toString = concat . (map toString)
    size = (foldr (+) 0) . (map size)
