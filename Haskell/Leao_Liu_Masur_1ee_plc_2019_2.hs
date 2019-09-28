-- Leao Liu Masur
-- 1
s1 ::(Ord a, Num a) => a -> Bool
-- s1 = (>5)
s1 = (\x -> x > 5)
s2 :: (Num a) => a -> a
--s2 = (+2)
s2 = (\x -> x + 2)


-- 2
-- a
merge :: (Ord a) => [a] -> [a] -> [a]
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:[]) (y:[])
    | x > y = [y, x]
    | otherwise = [x, y]
merge (x:xs) (y:ys)
    | x > y = [y] ++ merge (x:xs) ys
    | otherwise = [x] ++ merge xs (y:ys)

-- b
msort :: (Ord a) => [a] -> [a]
msort [] = []
msort x = merge a b
    where 
        (a, b) = metade x
-- c
metade :: [a] -> ([a], [a])
metade [] = ([], [])
metade [x] = ([x], [])
metade l = (take half l, drop half l)
   where
       half = (div (length l) 2)


-- 3 
type Texto = String
type Id = String
type DataHoraPub = Int

data Post = Post (Id, DataHoraPub) Texto deriving (Show, Eq)
data Thread = Nil | T Post (Thread) 

-- a
instance Show Thread where
    show Nil = ""
    show (T (Post (i, dh) tex) t) = "(" ++ i ++ " " ++ (show dh) ++ " " ++ tex ++ ")" ++ (show t)

-- b
inserirPost :: Post -> Thread -> Thread
inserirPost p Nil = (T p (Nil))
inserirPost p (T pt (t)) = (T p (T pt (t)))

-- c
threadToList :: Thread -> [Post]
threadToList Nil = []
threadToList (T pt (t)) = pt : (threadToList t)

-- d
listToThread :: [Post] -> Thread
listToThread [] = Nil
listToThread (x:xs) = (T x (listToThread xs))

-- e
isPostIn :: Post -> Post -> Bool
isPostIn (Post (a, b) c) = (\(Post (x, y) z) -> (a, b) /= (x, y))

removerPost :: (Id, DataHoraPub) -> Thread -> Thread
removerPost _ Nil = Nil
removerPost (i, d) t = threads
    where
        l = threadToList t
        l1 = filter (isPostIn (Post (i, d) "prop")) l
        threads = listToThread l1
        