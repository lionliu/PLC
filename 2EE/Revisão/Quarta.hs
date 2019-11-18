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


-- Tá dando erro pra compilar no get
get :: Buffer a -> STM a
get buff = do
    (x:tempBuff) <- readTVar buff
    writeTVar buff tempBuff
    return x
