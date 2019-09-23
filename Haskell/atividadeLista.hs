type Pessoa = String
type Livro = String
type BancoDados = [(Pessoa, Livro)]

baseExemplo :: BancoDados
baseExemplo = [("Adriano" , "One Piece"), ("Lucas", "One Piece"), ("Josugado", "Jonathan's Bizarre Adventure"), ("Josugado", "Attack on Titan")]

livros :: BancoDados -> Pessoa -> [Livro]
-- livros [] pessoa = []
-- livros ((p,l):corpo) pessoa 
--     | p == pessoa = l : livros corpo pessoa
--     | otherwise = livros corpo pessoa
livros bd pl = [l | (p,l) <- bd, p == pl]

emprestimos :: BancoDados -> Livro -> [Pessoa]
-- emprestimos [] livro = []
-- emprestimos ((p,l):corpo) livro
--     | l == livro = p : emprestimos corpo livro
--     | otherwise = emprestimos corpo livro
emprestimos bd lv = [p | (p,l) <- bd, l == lv]

emprestado :: BancoDados -> Livro -> Bool
emprestado [] livro = False
emprestado ((p,l):corpo) livro = (l == livro) || emprestado corpo livro

qtEmprestimos :: BancoDados -> Pessoa -> Int
qtEmprestimos [] pessoa = 0
qtEmprestimos ((p,l):cauda) pessoa
    | p == pessoa = 1 + qtEmprestimos cauda pessoa
    | otherwise = qtEmprestimos cauda pessoa

emprestar :: BancoDados -> Pessoa -> Livro -> BancoDados
-- emprestar bd pessoa livro = (pessoa, livro) : bd
emprestar bd pessoa livro = [(p, l) | (p, l) <- bd] ++ [(pessoa, livro)]

devolver :: BancoDados -> Pessoa -> Livro -> BancoDados
-- devolver [] pessoa livro = []
-- devolver ((p,l):cauda) pessoa livro 
--     | (p == pessoa) && (l == livro) = devolver cauda pessoa livro
--     | otherwise = devolver cauda pessoa livro ++ [(p,l)]
devolver bd pessoa livro = [(p,l) | (p,l) <- bd, p /= pessoa || l /= livro]


    