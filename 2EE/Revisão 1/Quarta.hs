import Control.Concurrent.STM
import Control.Concurrent.STM.TVar

-- Buffer vai ser uma lista de TVar do tipo a
type Buffer a = TVar [a]

newBuffer :: a -> IO (Buffer a)
newBuffer x = newTVarIO [x]

put :: Buffer a -> a -> STM()
put buffer var = do
    tempBuff <- readTVar buffer
    writeTVar buffer (tempBuff ++ [var])


get :: Buffer a -> STM a
get buff = do
    tvar <- readTVar buff
    if null tvar
        then retry -- retry vai reiniciar a função caso o buffer esteja vazio
        else return (head tvar)

        