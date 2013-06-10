module Tightrope where

import Control.Monad
import Control.Monad.State
import Control.Monad.Trans.Maybe

{-
  Pierre has decided to take a break from his job at the fish farm and
  try tightrope walking. He's not that bad at it, but he does have one problem:
  birds keep landing on his balancing pole! They come and they take a short rest,
  chat with their avian friends and then take off in search of breadcrumbs.
  This wouldn't bother him so much if the number of birds on the left side of
  the pole was always equal to the number of birds on the right side.
  But sometimes, all the birds decide that they like one side better and so
  they throw him off balance, which results in an embarrassing tumble for
  Pierre (he's using a safety net).
  
  Let's say that he keeps his balance if the number of birds on the left side
  of the pole and on the right side of the pole is within three.
  So if there's one bird on the right side and four birds on the left side,
  he's okay. But if a fifth bird lands on the left side, then he loses
  his balance and takes a dive.
-}
type Birds = Int  
type Pole = (Birds, Birds)


{-
First fix the functions for landing birds. Same function can be used to
take off birds by giving Birds parameter a negative value.

These are "simple" because they don't check for possible off balance.

Add given Birds amount to the correct side.

Example of a working function:
> simpleLandLeft 3 (0, 0)
(3, 0)
-}
simpleLandLeft :: Birds -> Pole -> Pole
simpleLandLeft n (left, right) = undefined
  
simpleLandRight :: Birds -> Pole -> Pole
simpleLandRight n (left, right) = undefined

-- | Helper function for easier chaining.
(-:) :: Pole -> (Pole -> Pole) -> Pole
x -: f = f x

{-
Testing it out.
Use -: function to chain landing two birds to left and two birds to right
Start > left 2 > left 2
-}
simpleLandTwoLeftTwoRight :: Pole -> Pole
simpleLandTwoLeftTwoRight pole = undefined

{-
Now create a longer chain with one parameter.

Start > left +1 > right + given amount > left -1 > right -2
-}
simpleLandingChain :: Birds -> Pole -> Pole
simpleLandingChain birds pole = undefined

{-
> simpleLandLeft 10 (0,3)
(10,3)
Way too unbalanced.

-- How about this?
> (0,0) -: simpleLandLeft 1 -: simpleLandRight 4 -: simpleLandLeft (-1) -: simpleLandRight (-2)
(0,2)

  It might seem like everything is okay but if you follow the steps here,
  you'll see that at one time there are 4 birds on the right side and no
  birds on the left! To fix this, we have to take another look at our
  landLeft and landRight functions. From what we've seen, we want these
  functions to be able to fail. That is, we want them to return a new pole
  if the balance is okay but fail if the birds land in a lopsided manner.
  And what better way to add a context of failure to value than by
  using Maybe! Let's rework these functions.
-}

-- Maybe
--------------------
{-
Here is the data type for Maybe. It can either have a value "Just <something>"
or no value at all "Nothing".
> :i Maybe
data Maybe a = Nothing | Just a

  Instead of returning a Pole these functions should return a Maybe Pole.
  They still take the number of birds and the old pole as before,
  but then they check if landing that many birds on the pole would throw
  Pierre off balance. We use guards to check if the difference between
  the number of birds on the new pole is less than 4. If it is, we wrap
  the new pole in a Just and return that.
  If it isn't, we return a Nothing, indicating failure.

> landLeft 2 (0,0)  
Just (2,0)  
> landLeft 10 (0,3)  
Nothing

Apply Maybe values in correct places in landLeft and landRight.
-}
landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
    | abs ((left + n) - right) < 4 = undefined
    | otherwise                    = undefined

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
    | abs (left - (right + n)) < 4 = undefined
    | otherwise                    = undefined

{-
Now reproduce land two left and two right with a Maybe context.

Tip: Here you need to use two of the functions defined in Monad class
-}
landTwoLeftTwoRight :: Pole -> Maybe Pole
landTwoLeftTwoRight pole = undefined

{-
Do the same thing for landingChain.
Start > left +1 > right + given amount > left -1 > right -2
-}
landingChain :: Birds -> Pole -> Maybe Pole
landingChain birds pole = undefined

{-
It's also worth taking a look at what this would look like if we hadn't made
the clever choice of treating Maybe values as values with a failure context
and feeding them to functions like we did. Here's how a series of
bird landings would look like:
-}

landingChain' :: Birds -> Pole -> Maybe Pole
landingChain' birds pole = case (landLeft 1) pole of
    Nothing -> Nothing
    Just pole1 -> case (landRight birds) pole1 of
        Nothing -> Nothing
        Just pole2 -> case (landLeft (-1)) pole2 of
            Nothing -> Nothing
            Just pole3 -> (landRight (-2)) pole3

-- do notation
--------------------------
{-
Let's first investigate >>= with lambda functions.

Start value + one lambda function ("show" turns data into a String):
> Just 3 >>= (\x -> Just (show x))
Just "3"

Start value + two lambda functions:
> Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y)))
Just "3!"

Now, let's put these functions on their own rows:
-}
foo :: Maybe String
foo = Just 3   >>= (\x ->
      Just "!" >>= (\y ->
      Just (show x ++ y)))

{-
And converting this to do notation we get rid of >>=:
-}
foodo :: Maybe String
foodo = do
  x <- Just 3
  y <- Just "!"
  Just (show x ++ y)
--  return (show x ++ y)
-- is fine too.

{-
Transform landTwoLeftTwoRight into do notation.
-}
doLandTwoLeftTwoRight :: Pole -> Maybe Pole
doLandTwoLeftTwoRight pole = do
  Nothing


-- IO monad
-------------------
{-
IO monad is used to input data and output data (surprise).
It represents something that can fail. Something that can have side effects.

Here is a small example of a routine that asks for values and then
runs a landing sequence with the data.

Try walkTheLine in ghci.
-}
walkTheLine :: IO ()
walkTheLine = do
  start <- getStart
  leftBirds <- getStep "Left ?"
  rightBirds <- getStep "Right ?"
 
  -- chained Maybe 
  let result = Just start >>= landLeft leftBirds >>= landRight rightBirds
  
  putStrLn $ "Result: " ++ show result


getStart :: IO Pole
getStart = do
  putStrLn "Start?"
  input <- getLine
  -- reads's signature can be tought as Read a => String -> [(a, String)]
  -- or input String -> [(parsed value, remaining String)]
  let poleS = reads input
  if null poleS
    then do
      putStrLn "No parse. Format is: (0,0)"
      getStart
    else return $ fst $ head poleS


getStep :: String -> IO Int
getStep msg = do
  putStrLn msg
  input <- getLine
  let intS = reads input
  if null intS
    then do
      putStrLn "No parse. Give an integer plz."
      getStep msg
    else return $ fst $ head intS



-- State monad and monad transformation
----------------------------------------
{-
Monad transformers are used to combine monads.
Most common monads have ready made transformer types, like:
> :t MaybeT
MaybeT :: m (Maybe a) -> MaybeT m a

This can be used to combine Maybe with other monads, like State.

Here is our own State that keeps track of the difference between
left and right birds:
-}
type DifferenceState = State Int
{-
This is actually DifferenceState a = State Int a
or State "State type" "data type".

So we want to wrap State monad around Maybe Pole:
DifferenceState (Maybe Pole) = State Int (Maybe Pole)

Then wrapping Maybe or MaybeT around that gives:

MaybeT DifferenceState Pole

Yay! Let's try it out:
-}

-- | Function that keeps track of current difference between
-- left and right bird count and lands given birds to left.
landLeftState :: Birds -> Pole -> MaybeT DifferenceState Pole
landLeftState n pole@(left, right) = do
      -- We could use "get" to get current state,
      -- but here we just use put to update the state.
      put difference
      
      -- 1. call landLeft
      -- 2. wrap it in our state
      -- 3. then wrap it in MaybeT
      MaybeT $ return $ landLeft n pole
    where difference = abs ((left + n) - right)

{-
To unwrap our result runMaybeT is used (run<monad> is common function for monads);
> :t runMaybeT
runMaybeT :: MaybeT m a -> m (Maybe a)

In our example: MaybeT DifferenceState Pole -> DifferenceState (Maybe Pole)

Then unwrapping state:
> :t runState
runState :: State s a -> s -> (a, s)

In our example: DifferenceState (Maybe Pole) -> 0 <start state> -> (Maybe Pole, ? <final state>)

Here are two different landing sequences.

Try them in ghci!
-}
balanced = runState (runMaybeT (landLeftState 3 (0,0) >>= landLeftState (-2) >>= landLeftState 1)) 0
tooMuch = runState (runMaybeT (landLeftState 3 (0,0) >>= landLeftState (-2) >>= landLeftState 4)) 0




























