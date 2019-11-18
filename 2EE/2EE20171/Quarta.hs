import Control.Concurrent.STM
import Control.Concurrent.STM.TVar

type Conta = TVar Int

saque :: Conta -> Int -> STM()
saque conta debito = do
    saldo <- readTVar conta
    writeTVar conta (saldo - debito)

deposito :: Conta -> Int -> STM()
deposito conta credito = do
    saldo <- readTVar conta
    writeTVar conta (saldo + credito)

saque2 :: Conta -> Int -> STM()
saque2 conta debito = do
    saldo <- readTVar conta
    if ((saldo - debito) < 0)
        then retry
        else writeTVar conta (saldo - debito)

saque3 :: Conta -> Conta -> Int -> STM()
saque3 contaA contaB debito = do
    orElse (saque2 contaA debito) (saque2 contaB debito) -- no orElse, se a primeira funcao travar, vai ativar a segunda no lugar.