qs :: [Int] -> [Int]
qs [] = []
qs (a:b) = qs [x | x <- b, x < a] ++ [a] ++ qs [x | x <- b, x >= a]
