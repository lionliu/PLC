-- mvar

module Main where
import Control.Concurrent
import Control.Concurrent.MVar

-- Se for interagir com algum MVar vazio num takeMVar, a thread atual trava até que MVar não esteja vazio.
-- takeMVar também esvazia a MVar e avisa outras threads sobre isso, por exemplo, se uma putMVar travou e está esperando ser chamada.

threadA :: MVar Float -> MVar Float -> IO ()
threadA toSend toReceive = do
    putMVar toSend 72 -- escreve 72 no toSend
    v <- takeMVar toReceive -- coloca em v o valor escrito em toReceive
    putStrLn (show v)

threadB :: MVar Float -> MVar Float -> IO ()
threadB toReceive toSend = do
    z <- takeMVar toReceive -- Coloca em z o valor de toReceive
    putMVar toSend (1.2 * z) -- Coloca em toSend 1.2 * z

main :: IO()
main = do
    aMVar <- newEmptyMVar
    bMVar <- newEmptyMVar
    forkIO (threadA aMVar bMVar)
    forkIO (threadB aMVar bMVar)
    threadDelay 1000 -- Espera 1 seg
