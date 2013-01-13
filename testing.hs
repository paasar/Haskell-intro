import Test.QuickCheck
import Test.HUnit

-- HUnit unit testing example
-------------------------------
maxThree :: (Ord a) => a -> a -> a -> a
maxThree x y z
  | x > y && x > z = x
  | y > x && y > z = y
  | otherwise      = z
  
testMax1 = TestCase (assertEqual "for: maxThree 6 4 1" 6 (maxThree 6 4 1))
testMax2 = TestCase (assertEqual "for: maxThree 6 6 6" 6 (maxThree 6 6 6))
testMax3 = TestCase (assertEqual "for: maxThree 2 6 6" 6 (maxThree 2 6 6))
testMax4 = TestCase (assertEqual "for: maxThree 2 2 6" 6 (maxThree 2 2 6))
testMax5 = TestCase (assertEqual "for: maxThree 6 6 2" 6 (maxThree 6 6 2))

testsMax = TestList [testMax1
                    , testMax2
                    , testMax3
                    , testMax4
                    --, testMax5
                    ]
-- > runTestTT testMax


-- Example on QuickCheck and limitations of Int
------------------------------------------------
fact :: Int -> Int
fact x
  | x > 1 = x * fact (x - 1)
  | otherwise = 1

prop_fact n = fact n > 0

-- > quickCheck prop_fact

-- Other QuickCheck example
------------------------------
doubleMe x = x*x

prop_dMeLargerThanInput z = doubleMe z >= z
-- > quickCheck prop_dMeLargerThanInput

-- <precondition> ==> <property test>
prop_dMeGreaterThanZero z =
  z > 0 ==>
  doubleMe z > 0
-- > quickCheck prop_dMeGreaterThanZero

-- There are generators and you can create own generators for value creation.