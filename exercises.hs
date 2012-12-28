{-
-- Start ghci in the same directory where this file is.
-- If you get "Segmentation fault", try again (it's a bug in Mac-version)
-}

-- Functions
-----------------------
-- name [params] = <functionality>
-- ! Create a doubleMe function that doubles given parameter



{-
> :load exercises
Ok, modules loaded: Main.
> doubleMe 8
??
> doubleMe 6.3
??
-}

-- ! Create doubleUs function that takes two parameters doubles and sums them up



{-
-- reload files to force ghci see the modifications made
> :reload
Ok, modules loaded: Main.
> doubleUs 3 5
??
-}

-- if-then-else
-----------------------
-- You can do ternary operation inside a function with if-then-else.
-- ! Create function that doubles number that are smaller than 100
--   and otherwise returns given number as is.



{-
> :r
Ok, modules loaded: Main.
> doubleSmallNumber 50
??
> doubleSmallNumber 101
??

-----------------------
-- ! Looking at a type of a function
> :type doubleMe
doubleMe :: Num a => a -> a
> :t doubleSmallNumber
doubleSmallNumber :: (Num a, Ord a) => a -> a
-- What's an Ord? Let's find out:
> :t Ord
??
-- We get an error, because Ord isn't a type.
-- It's a Class (it's similar to imperative programming "interface").
> :info Ord
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  (<) :: a -> a -> Bool
  (>=) :: a -> a -> Bool
  (>) :: a -> a -> Bool
  (<=) :: a -> a -> Bool
  max :: a -> a -> a
  min :: a -> a -> a
...(lots of other stuff)
-}

-- Lists
-----------------------
l = [1,2,3]
l2 = l ++ [4,5,6]

{-
> l2
??
-- You can set variables in ghci (and in certain contexts in code) with let:
> let l3 = [7,8,9]
> 6 : l3
??
> l3
??
-- l3 is actually 7:8:9:[] or 7:8:[9] or 7:[8,9]
-- This comes in handy when recursing a list:
-- recurseList (x:xs) = operation x : recurseList xs

-- Strings
-----------------------
> let text = "Houston!"
> "Hello " ++ text

> let alph = "bcde"
> 'a' : alph
??
> alph : 'f'
??
-- Didn't work that way...
-- You can either turn character into a string and concatenate with ++ (expensive)
-- or reverse alph, add character and reverse again (':' is quite quick, but reversing twice..?)

-- head, tail, last, init
> head alph
??

-- Infinite list
-----------------------
-- Because Haskell is lazy nothing is evaluated before it is actually needed.
> let inf = [1..]
> take 10 inf

-- You can use ctrl-c to stop showing plain inf.


-- Infix function
-----------------------
-- Use backticks to make function infix (fun a b becomes a `fun` b).
> 4 `elem` [3,4,5]
??
> 9 `elem` [3,4,5]
??
-- ! Can you guess what :t elem looks like?

-- Other stuff
-----------------------
> let inf2 = [2,4..]
> take 20 inf2
??
> ['a'..'z']
??

-- Funky stuff
-----------------------
> [0.1, 0.3 .. 1]
??

-- List comprehensions
-----------------------
> [x*2 | x <- [1..10]]
??
-- ! From a list of 1 to 10 pick those numbers that are bigger than 12 when doubled.
> [x | x <- [1..10], <your rule here>]


-- ! Make the result a list of tuples of the original x and its doubled value.
--   Tuple is made with parentheses like this: (something, something).
> ??


-- Pattern matching
-----------------------
-- Create a function that takes Integral and returns String.
-- Like this: sayMe 1 gives "One!", sayMe 2 gives "Two!".
-- Three is enough for now.
-- Here is the signature:
-}
-- sayMe :: (Integral a) => a -> String

{-
> sayMe 1
??
> sayMe 4
??

-- ! Oops... Let's fix it by adding catch all at the end.
-- Underscore means value we are not interested in):



> :r
> sayMe 4
??

-}
-- Pattern matching example with tuples
------------------------------------------
-- Lets create function that adds two dimensional vectors together.
-- In other words takes two vectors and return a new vector where xs and ys are summed up.
-- Instead of creating signature: addVectors :: (Num, Num) -> (Num, Num) -> (Num, Num)
--   we can use "=>" to say "a is Num" and then repeat just a.
-- ! Create function body (function takes two parameters).
--   (use fst to get tuple's first element and snd to get its second element)
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors = undefined

-- And better way to do it is looking straight into a tuple:
addVectors' :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors' = undefined

-- Write a "first" function for a three tuple.
first = undefined
{-
-- Test:
> first (4,5,6) == 4
True
> first (5,6,7) == 5
True
> first (5,6,7) == 6
False




-- Guards
-----------------------
max' :: (Ord a) => a -> a -> a
max' a b
    | a > b     = a
    | otherwise = b

-}
bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise                   = "You're a whale, congratulations!"

-- Use where-clause to reduce repetition
bmiTell' :: (RealFloat a) => a -> a -> String  
bmiTell' weight height  
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2

-- Using "let" in code.
-----------------------
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^2
    in  sideArea + 2 * topArea

{-
-- Whether to use let-in or where depends on which is better for readability.

-- Let can also be used to make inline functions.
> [let square x = x * x in (square 5, square 3, square 2)]
[(25,9,4)]
-}

-- How to use case
-----------------------
describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."   
                                               xs -> "a longer list."
-- ! Try giving describeList function lists of different size in ghci.


-- Recursion ftw
-----------------------
-- ! Recurse a list of Ints and add one to each of the elements.
--   Start with edge case: empty list returns empty list.
--   Remember how you get first and rest of a list in pattern matching?
--   Actual function sums first with one, concatenates it to the rest with
--   ":" and the rest is used in recursive call.
addOneToAll = undefined

-- Another way to do it is using case:
addOneToAll' = undefined


-- Map
-----------------------
-- Can you figure how to do addOneToAll with a map function?
-- Hoogle "map"


-- Apply what you learned here:
addOneToAll'' = undefined

{-
-- Fold...
-----------------------
> :t foldl
foldl :: (a -> b -> a) -> a -> [b] -> a
-- It takes a function, that takes two parameters and returns a value)
-- and a variable (accumulator)
-- and list of something
-- and returns a value.
-- Meaning: It goes through a list and accumulates something into result
--          as dictated by the given function.

-- We can use lambda (anonymous function)
      lambda    accumulator  list
          |             |   |
> foldl (\x y -> x + y) 0 [1,2,3]
6

-- You can use foldl1 to use first element as the accumulator starting point
> foldl1 (\x y -> x + y) [1,2,3]
6
-}

-- Data
-----------------------
type Name = String

-- First name, Last name, Age
data Person = Person Name Name Int
  deriving Show

getFirstName :: Person -> Name
getFirstName (Person fn _ _) = fn

p1 = Person "Elli" "Esimerkki" 21

{-
> getFirstName p1
"Elli"

-- Not very handy because we need to remember order of parameters
-- when creating a new Person
-- and need to create those 'extracting' functions by hand.
-}

-- Better way to do it:
data Person2 = Person2
               {
                 firstName :: Name
               , lastName :: Name
               , age :: Int
               } deriving Show

-- create person
p2 = Person2 {
               firstName="Esko"
             , lastName="Esimerkki"
             , age=21
             }
{-
-- We get automagically all 'extracting' functions:
> firstName p2
"Esko"
-}

-- Own types
-----------------------
-- ! First add "deriving Show" to this type:
data TrafficLight = Red | Yellow | Green

{-
> let g = Green
> g
??
-}

-- We get more control with instance definition
-- ! Remove "deriving Show" and uncomment this
{-
instance Show TrafficLight where
  show Red = "Red Light"
  show Yellow = "Yellow Light"
  show Green = "Green Light"
-}
{-
> let g = Green
> g
??
> :t g
g :: TrafficLight
-}
{-
-- ! Can we compare them?
> Red == Green
??
-}
-- uncomment
{-
instance Eq TrafficLight where
    Red == Red = True
    Green == Green = True
    Yellow == Yellow = True
    _ == _ = False
-}
{-
> Red == Green
??
> Red == Red
??
-}
-- Okay, we could have used deriving Eq here.
