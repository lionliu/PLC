-- É similar a interfaces em java

memberList :: (Eq t) => [t] -> t -> Bool
memberList [] b = False
-- Pelo tipo t estar instanciado como a classe Eq, é possivel utilizar o operador ==
memberList (a:as) b = (a==b) || memberList as b

-- Conseguimos instancias num data via o deriving


data Curso = Manha String | Tarde String

instance Eq Curso where
        (Manha n1) == (Manha n2) = n1 == n2
        (Tarde n3) == (Tarde n4) = n3 == n4
        -- Se for chamado um (Manha "aa") == (Tarde "aa") vai levar uma exception, pois a definicao ainda não foi definida.
        -- Definindo a definicao
        _ == _ = False

-- Criando classe

class Visivel t where
        toString :: t -> String
        size -> :: t -> Int

instance Visivel Bool where
    toString True = "True"
    toString False = "False"
    size _ = 1

instance Visivel a => Visivel [a] where
    toString = concat . (map toString)
    size = (foldr (+) 0) . (map size)
