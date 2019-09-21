inc :: Int -> Int
inc x = x + 1

aplica2x :: (t -> t) -> t -> t
aplica2x f x = (f . f) x

iter :: Int -> (t -> t) -> (t -> t)
iter 0 f = id
iter n f = (iter (n-1) f) . f

addNumLambda :: Int -> (Int -> Int)
addNumLambda n = (\x -> n + x)

f l = ( (map (\x -> x > 6)) . (filter (\x -> mod x 2 == 0))) l
-- filter . map não irá funcionar