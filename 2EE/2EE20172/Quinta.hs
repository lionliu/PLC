import Control.Concurrent
import Control.Concurrent.STM
import Control.Concurrent.STM.TVar
import Control.Concurrent.MVar

data Pao = Frances deriving Show
data Tomate = Vermelho deriving Show
data Carne = Presunto deriving Show
type Sanduiche = TVar (Pao, Tomate, Carne)

