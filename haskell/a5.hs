
-- Basic Functions

snoc :: a -> [a] -> [a]
snoc a [] = a:[]
snoc a (x:xs) = x:(snoc a xs)

myappend :: [a] -> [a] -> [a]
myappend lst1 lst2 
	| null lst1 && null lst2 = []
	| null lst1 = lst2
	| null lst2 = lst1
	| otherwise = (head lst1):(myappend (tail lst1) lst2)

myreverse :: [a] -> [a]
myreverse [] = []
myreverse (x:xs) = (myreverse xs) ++ [x]

-- https://stackoverflow.com/questions/19725292/how-to-reverse-an-integer-in-haskell
reverseInt :: Int -> Int
reverseInt x | x < 0     = 0 - (read . reverse . tail . show $ x)
			| otherwise = read . reverse . show $ x
 
-- src: http://www.cs.sfu.ca/CourseCentral/383/tjd/haskell_functions_lhs.html
smallest_divisor :: Int -> Int
smallest_divisor n
    | n < 0     = error "n must be >= 0"
    | n == 0    = 0
    | n == 1    = 1
    | otherwise = head (dropWhile (\x -> n `mod` x /= 0) [2..n])

-- src: http://www.cs.sfu.ca/CourseCentral/383/tjd/haskell_functions_lhs.html
is_prime :: Int -> Bool
is_prime n | n < 2     = False
           | otherwise = (smallest_divisor n) == n

is_emirp :: Int -> Bool
is_emirp n = ((is_prime n) && (is_prime (reverseInt n)) && (reverseInt n) /= n) 
		
-- An emirp:
-- a prime number 
-- different prime when its digits are reversed.
count_emirps :: Int -> Int
count_emirps n = length (filter is_emirp [2..n])

biggest_sum :: [[Int]] -> [Int]
biggest_sum [x] = x
biggest_sum (x:xs)   
	| (sum x) > sum (biggest_sum xs) = x
	| otherwise = biggest_sum xs   

greatest :: (a -> Int) -> [a] -> a
greatest f [x] = x
greatest f (x:xs)   
    | (f x) > (f (greatest f xs)) = x
    | otherwise = greatest f xs   

-- Basic Bits

is_bit :: Int -> Bool
is_bit x = if x == 0 || x == 1 then True
		else False

flip_bit :: Int -> Int
flip_bit x 
	| x == 0 = 1
	| x == 1 = 0
	| otherwise = error "input is not 0 or 1"

is_bit_seq1 :: [Int] -> Bool
is_bit_seq1 seq
	| null seq = True
	| not (is_bit (head seq)) = False
	| otherwise = is_bit_seq1(tail seq)

is_bit_seq2 :: [Int] -> Bool
is_bit_seq2 seq = 
	if null seq 
		then True 
	else if not (is_bit (head seq)) 
		then False
	else is_bit_seq2(tail seq)

is_bit_seq3 :: [Int] -> Bool
is_bit_seq3 seq = all is_bit seq

invert_bits1 :: [Int] -> [Int]
invert_bits1 [] = []
invert_bits1 (x:xs) = (flip_bit x):(invert_bits1 xs)

invert_bits2 :: [Int] -> [Int]
invert_bits2 [] = []
invert_bits2 seq = map flip_bit seq
 
invert_bits3 :: [Int] -> [Int]
invert_bits3 xs = [ flip_bit x | x <- xs ]

bit_count :: [Int] -> (Int, Int)
bit_count [] = (0, 0)
bit_count seq = 
			let 
				one  = filter (\y -> y==1) seq
				zero = filter (\y -> y==0) seq
			in (length one, length zero)

-- https://stackoverflow.com/questions/24385956/why-is-one-way-of-generating-binary-sequences-faster-than-another
all_basic_bit_seqs :: Int -> [[Int]]
all_basic_bit_seqs n = sequence (replicate n [0,1])

-- Type-checked Bits

data Bit = Zero | One
    deriving (Show, Eq)

flipBit :: Bit -> Bit
flipBit b 
	| b == Zero = One
	| b == One = Zero
	| otherwise = error "Requires input of type Bit"

invert :: [Bit] -> [Bit]
invert seq
	| null seq = []
	| otherwise = map flipBit seq  

-- https://stackoverflow.com/questions/24385956/why-is-one-way-of-generating-binary-sequences-faster-than-another
all_bit_seqs :: Int -> [[Bit]]
all_bit_seqs n = sequence (replicate n [Zero,One])

-- helper for bitSum
bitToInt :: Bit -> Int
bitToInt b
	| b == Zero = 0
	| b == One = 1

-- TODO: Redo without recursion
bitSum1 :: [Bit] -> Int
bitSum1 lst = sum (map bitToInt lst)


bitSum2 :: [Maybe Bit] -> Int
bitSum2 [] = 0
bitSum2 lst 
	| null lst = 0
	| ((head lst) == Just One) = 1 + bitSum2 (tail lst)
	| otherwise = bitSum2 (tail lst)
	
-- A Custom List Data Type

data List a = Empty | Cons a (List a)
    deriving Show
    
toList :: [a] -> List a
toList [] = Empty
toList (x:xs) = Cons x (toList (xs))

toHaskellList :: List a -> [a]
toHaskellList Empty = []
toHaskellList (Cons x xs) = x:toHaskellList(xs)

append :: List a -> List a -> List a
append Empty Empty = Empty
append Empty (Cons x xs) = (Cons x xs)
append (Cons x xs) Empty = (Cons x xs)
append (Cons x xs) (Cons y ys) = Cons x (append xs (Cons y ys))
	
removeAll :: (a -> Bool) -> List a -> List a 
removeAll f Empty = Empty
removeAll f (Cons x xs)
	| f x == False = Cons x (removeAll f xs)
	| otherwise = removeAll f xs

sort :: Ord a => List a -> List a
sort Empty = Empty
sort (Cons x xs) = 
				let 
					smalls = (sort (removeAll (\n -> n > x) xs))
					bigs = (sort (removeAll (\n -> n <= x) xs))
				in 
					smalls `append` (Cons x Empty) `append` bigs