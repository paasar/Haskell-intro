import Test.HUnit

import Tightrope

simpleLandingTests = TestList [
  -- description ~: expected ~=? actual
    "(0, 0) +2 left " ~: (2, 0) ~=? simpleLandLeft 2 (0, 0)
  , "(1, 0) +1 left " ~: (2, 0) ~=? simpleLandLeft 1 (1, 0)
  , "(1, 2) +1 right" ~: (1, 3) ~=? simpleLandRight 1 (1, 2)
  , "(1, 2) -1 right" ~: (1, 1) ~=? simpleLandRight (-1) (1, 2)
  , "(0, 0) +2 l, +1 r, +1 l" ~: (3, 1) ~=? simpleLandLeft 2 (simpleLandRight 1 (simpleLandLeft 1 (0,0)))
  , "(0, 0) +2 l, +1 r, +1 l" ~: (3, 1) ~=? ((0, 0) -: simpleLandLeft 2 -: simpleLandLeft 1 -: simpleLandRight 1)
  , "(0, 0) +2 left, +2 right" ~: (2, 2) ~=? simpleLandTwoLeftTwoRight (0, 0)
  , "(1, 2) +2 left, +2 right" ~: (3, 4) ~=? simpleLandTwoLeftTwoRight (1, 2)
  , "(0, 0) simpleLandingChain with 3" ~: (0, 1) ~=? simpleLandingChain 3 (0, 0)
  , "(0, 0) simpleLandingChain with 4" ~: (0, 2) ~=? simpleLandingChain 4 (0, 0)
  ]

maybeLandingTests = TestList [
    "(0, 0) maybe +2 left" ~: Just (2, 0) ~=? landLeft 2 (0, 0)
  , "(0, 3) maybe +10 left" ~: Nothing ~=? landLeft 10 (0, 3)
  , "(0, 0) maybe +2 left, +2 right" ~: Just (2, 2) ~=? landTwoLeftTwoRight (0, 0)
  , "(1, 2) maybe +2 left, +2 right" ~: Just (3, 4) ~=? landTwoLeftTwoRight (1, 2)
  , "(0, 0) landingChain with 3" ~: Just (0, 1) ~=? landingChain 3 (0, 0)
  , "(0, 0) landingChain with 4" ~: Nothing ~=? landingChain 4 (0, 0)
  , "(0, 0) do maybe +2 left, +2 right" ~: Just (2, 2) ~=? doLandTwoLeftTwoRight (0, 0)
  , "(1, 2) do maybe +2 left, +2 right" ~: Just (3, 4) ~=? doLandTwoLeftTwoRight (1, 2)
--  , "" ~: ~=?
  ]

allTests = TestList [
    simpleLandingTests
  , maybeLandingTests
  ]

main = run

run = do
  runTestTT allTests