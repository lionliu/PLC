import Control.Concurrent
import Control.Concurrent.MVar

type Bulbo = String
type Soquete = String

type Lampada = (Bulbo, Soquete)
data LampadaEmbalada = Embalagem Lampada
type Caixa = [LampadaEmbalada]

-- não sei fazer o resto(ainda)