-- Print: putStrLn :: String -> IO ()

imprime :: String ->  IO ()
imprime str = putStrLn str

-- tipo IO t retornam valor do tipo t
-- No caso do putStr, o tipo retornado é (), entao o retorno é insignificante
-- scan: getLine :: IO String 

-- não é possivel chamar 2 putStrLn seguidos, pois no primeiro puStrLn é retornado (), e no segundo ele espera uma string
-- Deve ser chamado assim com o do
-- imprime2 :: String -> IO ()
-- imprime2 str = do putStrLn str
--                 putStrLn str

-- Com o <- vai extrair a string do IO String
prntStrInput :: IO ()
prntStrInput = do 
    l <- getLine
    putStrLn l
    putStrLn l

imprimeInvertido :: IO ()
imprimeInvertido = do
    l1 <- getLine
    l2 <- getLine
    putStrLn (reverse l2)
    putStrLn (reverse l1)

-- Para rodar o .hs como se fosse um script é só fazer uma funcao main e rodar no console com ./aulaIO

-- main = do
--     return ()
--     l1 <- return "kek"
--     line <- getLine
--     -- O return nao vai parar o programa. O return em haskell "empacota" o valor, e vc consegue pega-lo com o <-
--     return "Oloko bicho"
--     puStrLn line
--     puStrLn l1

main = do
    line <- getLine
    if null line
    then return ()
    else (do 
        putStrLn $ reverseWords line
        main)
    
reverseWords :: String -> String
reverseWords = unwords . map reverse . words

showStackHead [] = return []
showStackHead (x:x2) = do
    putStrLn $ "resultado" ++ [x]
    return x2


main :: IO ()
