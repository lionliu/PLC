inc :: Int -> Int
inc x = x + 1

aplica2x :: (t -> t) -> t -> t
aplica2x f x = (f . f) x

-- Aplica a função recebida nela mesma n vezes e no final faz a funçao com a entrada recebida
-- Ex: (iter 10 (+ 30)) 25 = 325. Se somou 30 10 vezes, e no final somasse com 25
iter :: Int -> (t -> t) -> (t -> t)
iter 0 f = id
iter n f = (iter (n-1) f) . f

addNumLambda :: Int -> (Int -> Int)
addNumLambda n = (\x -> n + x)

f l = ( (map (\x -> x > 6)) . (filter (\x -> mod x 2 == 0))) l
-- filter . map não irá funcionar

f1 :: t -> u -> v
f2 :: u -> t -> v
