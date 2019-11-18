import Control.Concurrent.STM
import Control.Concurrent.STM.TVar

type Semaforo = TVar Bool

p :: Semaforo -> STM()
p semaforo = do 
    sem <- readTVar semaforo
    if(sem)
        then writeTVar semaforo False
        else retry

v :: Semaforo -> STM()
v semaforo = do
    writeTVar semaforo True