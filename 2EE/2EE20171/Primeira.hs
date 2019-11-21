import Control.Concurrent
import Control.Concurrent.MVar

consumer :: MVar Int -> IO()
consumer lampadas = do
    tempLampadas <- takeMVar lampadas
    if tempLampadas >= 50 then do
        putMVar lampadas 0
        putStrLn "Mandando uma caixa"
        threadDelay 30000
        consumer lampadas
    else do
        putMVar lampadas tempLampadas
        putStrLn "Lampadas insuficientes"
        threadDelay 150000 -- Esperar ficar pronto
        consumer lampadas
    

producerLampada :: MVar Int ->  MVar Int -> MVar Int -> MVar Int -> IO()
producerLampada soquetes bulbos embalagens lampadas = do
    tempSoquetes <- takeMVar soquetes
    tempBulbos <- takeMVar bulbos
    tempEmbalagens <- takeMVar embalagens
    if tempBulbos > 0 && tempEmbalagens > 0 && tempEmbalagens > 0 then do
        tempLampadas <- takeMVar lampadas
        putStrLn (show (tempLampadas + 1))
        putMVar bulbos (tempBulbos - 1)
        putMVar soquetes (tempSoquetes - 1)
        putMVar embalagens (tempEmbalagens - 1)
        putMVar lampadas (tempLampadas + 1)
        putStrLn "Montando uma lampada"
        threadDelay 30000
        producerLampada soquetes bulbos embalagens lampadas
    else do
        putMVar bulbos tempBulbos
        putMVar soquetes tempSoquetes
        putMVar embalagens tempEmbalagens
        putStrLn "Componentes insuficientes"
        threadDelay 50000 -- Esperar ficar pronto
        producerLampada soquetes bulbos embalagens lampadas
    

producer :: MVar Int -> String -> IO()
producer componente nome = do
    tempComponente <- takeMVar componente
    putMVar componente (tempComponente + 1)
    putStrLn ("Criando " ++ nome)
    threadDelay 30000
    producer componente nome

main :: IO()
main = do
    lampadas <- newMVar 0
    bulbos <- newMVar 0
    soquetes <- newMVar 0
    embalagens <- newMVar 0

    forkIO (consumer lampadas)
    forkIO (producerLampada soquetes bulbos embalagens lampadas)
    forkIO (producer bulbos "bulbo")
    forkIO (producer embalagens "embalagem")
    forkIO (producer soquetes "soquete")
    threadDelay 5000000000 -- não deixar o programa acabar
    return ()

