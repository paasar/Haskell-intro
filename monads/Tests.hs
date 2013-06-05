import Test.HUnit

import Tightrope

badLandingTests = TestList [
    "(0, 0) +2 left " ~: (2, 0) ~=? badLandLeft 2 (0, 0)
  , "(1, 0) +1 left " ~: (2, 0) ~=? badLandLeft 1 (1, 0)
  , "(1, 2) +1 right" ~: (1, 3) ~=? badLandRight 1 (1, 2)
  , "(1, 2) -1 right" ~: (1, 1) ~=? badLandRight (-1) (1, 2)
  , "(0, 0) +2 l, +1 r, +1 l" ~: (3, 1) ~=? badLandLeft 2 (badLandRight 1 (badLandLeft 1 (0,0)))
  , "(0, 0) +2 l, +1 r, +1 l" ~: (3, 1) ~=? ((0, 0) -: badLandLeft 2 -: badLandLeft 1 -: badLandRight 1)
  , "(0, 0) +2 left, +2 right" ~: (2, 2) ~=? badLandTwoLeftTwoRight (0, 0)
  , "(1, 2) +2 left, +2 right" ~: (3, 4) ~=? badLandTwoLeftTwoRight (1, 2)
  , "(0, 0) landingChain with 3" ~: (0, 1) ~=? badLandingChain 3 (0, 0)
  , "(0, 0) landingChain with 4" ~: (0, 2) ~=? badLandingChain 4 (0, 0)
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
    badLandingTests
  , maybeLandingTests
  ]

main = run

run = do
  runTestTT allTests