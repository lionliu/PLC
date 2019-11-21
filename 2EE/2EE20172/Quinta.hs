import Control.Concurrent
import Control.Concurrent.MVar
import Control.Concurrent.STM

-- Sua função: verifica se após fim (modificado pelas threads) chegou a zero.
-- Encerra o loop caso sim, encerrando o main que encerra as threads
waitThreads :: MVar Int -> IO ()
waitThreads fim = do
    f <- takeMVar fim
    if (f > 0) then do
        putMVar fim f
        waitThreads fim
    else
        return ()


-- Isso é tipo classe, seta as quantidades fornecidas e se chama
produtor :: TVar Int -> TVar Int -> TVar Int -> MVar Int -> IO ()
produtor pao carne tomate fim = do
    -- Quando se pega uma MVar, funcionaria como uma condicional, pois se a MVar não estivesse disponivel, a thread travaria até ficar disponivel.
    -- A mesma coisa seria analoga ao comsuimidor, quando ele der um takeMVar depois desse ponto, ele que irá travar até chegar no putMVar
    fimAtual <- takeMVar fim
    atomically (do 
        writeTVar pao 30
        writeTVar carne 30
        writeTVar tomate 30)
        

    putMVar fim (fimAtual-1)
    produtor pao carne tomate fim

-- Isso é tipo classe, consome os produtos, e se chama de novo
consumidor :: TVar Int -> TVar Int -> TVar Int -> MVar Int -> MVar Int -> IO ()
consumidor pao carne tomate faca fim = do
    -- Fim == quantida de execuções
    direitoFaca <- takeMVar faca
    fimAtual    <- takeMVar fim

    -- Para produzir um sanduíche, são gastos 1 de cada:
    -- Então faço a leitura do dado, e gasto, isso é tipo get() e set() em Java
    atomically (do
        estoquePaoAtual <- readTVar pao
        estoqueCarneAtual <- readTVar carne    
        estoqueTomateAtual <- readTVar tomate

        writeTVar pao (estoquePaoAtual-1)
        writeTVar carne (estoquePaoAtual-1)
        writeTVar tomate (estoquePaoAtual-1))

        
    putMVar faca direitoFaca
    putMVar fim (fimAtual-1)
    consumidor pao carne tomate faca fim

main :: IO ()
main = do
    -- Inicia estoque inicial dos ingredientes
    let qtdIng = 30
    pao    <- atomically (newTVar qtdIng)
    carne  <- atomically (newTVar qtdIng)
    tomate <- atomically (newTVar qtdIng)

    -- Controla a concorrência 
    -- (quantidade de execuções e o objeto de disputa: faca)
    lockFaca <- newMVar 0 -- Faca tem que ser MVar mesmo, pois vai funcionar como um "monitor"
    qtdExec <- newMVar 20

    -- A partir de agora, pode-se iniciar a execução

    -- Iniciando as threads: 1 produtora, 2 consumidoras
    forkIO(produtor pao carne tomate qtdExec)
    forkIO(consumidor pao carne tomate lockFaca qtdExec)
    forkIO(consumidor pao carne tomate lockFaca qtdExec)
    waitThreads qtdExec
    return ()
    -- O main chamou as threads,
    -- elas executam waitThreads e depois o código acaba