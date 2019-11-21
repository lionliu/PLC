import Control.Concurrent
import Control.Concurrent.MVar
import Control.Concurrent.STM
-- Já tá feita em outras provas

waitThread :: MVar Int -> IO()
waitThread contagem = do
    tempContagem <- takeMVar contagem
    if tempContagem > 0 then do
        putMVar contagem tempContagem
        waitThread contagem
    else
        return ()

-- consumidor :: TVar Int -> TVar Int 

-- main :: IO ()
-- main = do
