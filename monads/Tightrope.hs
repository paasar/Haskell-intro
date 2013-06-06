module Tightrope where

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
simpleLandLeft n (left, right) = (left, right)
  
simpleLandRight :: Birds -> Pole -> Pole
simpleLandRight n (left, right) = (left, right)

-- | Helper function for easier chaining.
(-:) :: Pole -> (Pole -> Pole) -> Pole
x -: f = f x

{-
Testing it out.
Use -: function to chain landing two birds to left and two birds to right
Start > left 2 > left 2
-}
simpleLandTwoLeftTwoRight :: Pole -> Pole
simpleLandTwoLeftTwoRight pole = (-1, -1)

{-
Now create a longer chain with one parameter.

Start > left +1 > right + given amount > left -1 > right -2
-}
simpleLandingChain :: Birds -> Pole -> Pole
simpleLandingChain birds pole = (-1, -1)

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













