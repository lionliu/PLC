import Control.Concurrent
import Control.Concurrent.MVar
import Control.Concurrent.STM


        
produtor :: TVar Int -> String -> IO()
produtor componente nome = do

    atomically (do
        tempComponente <- readTVar componente
        --putStrLn ("Produzindo " ++ nome)
        --putStrLn (show tempComponente)
        writeTVar componente (tempComponente + 1))

    produtor componente nome


produtorCaixa :: TVar Int -> TVar Int -> TVar Int -> IO()
produtorCaixa parafusos porcas caixaPar = do

    atomically (do
        qtParafuso <- readTVar parafusos
        qtPorcas <- readTVar porcas
        
        if qtParafuso > 0 && qtPorcas > 0 then do
            qtCaixa <- readTVar caixaPar
            --putStrLn "Produzindo um par"
            --putStrLn (show qtCaixa + 1)
            writeTVar caixaPar (qtCaixa + 1)
            writeTVar parafusos (qtParafuso - 1)
            writeTVar porcas (qtPorcas - 1)
        else retry)

    produtorCaixa parafusos porcas caixaPar

main :: IO()
main = do

    porcas <- newTVarIO 0
    parafusos <- newTVarIO 0
    caixaPar <- newTVarIO 0

    forkIO (produtor porcas "porca")
    forkIO (produtor parafusos "parafuso")
    forkIO (produtorCaixa parafusos porcas caixaPar)
    threadDelay 50000000000 -- Fazer com que o programa não acabe
    return ()