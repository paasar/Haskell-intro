


main = do
  putStrLn "Mission 1: Pairs of programming\n"
  -- Mission 1: Pairs of programming
  -- You'll need an input file with names (one name per row).
  -- In ghci use ":l mission", and "main" to run this program. After first load you can use ":reload".
  
  -- Task 1: Open file and _get contents_ from it.
  --         Add file closing to the end of main function.
  -- Tip 1: Check Hackage (http://hackage.haskell.org/packages/archive/base/latest/doc/html/System-IO.html)
  --        You'll need to import it.
  -- Tip 2: Returned handle can be stored in a variable with "<-" "operator".
  --        "<-" Is used when 'extracting' values from Monads, like in this case
  --        returned value is "IO Handle".
  
  
  
  -- Task 2: Parse the contents into list of Strings.
  -- Pro tip: Hoogle: String -> [String]
  -- Tip: You can use let to create an variable here.
  
  -- "putStrLn" prints out anything that derives Show (eg. list of Strings)
  --putStrLn names
  
  -- Task 3: Introduce a function that creates list of unique pairs (tuples).
  --         ["a", "b", "c"] --> [("a", "b"), ("a", "c"), ("b", "c")]
  
  --putStrLn pairs
  
  -- Task 4: Print it pretty (pair per row, no brackets and put ampersand between people).
  --         Example row: Haskell Curry & Simon Peyton Jones
  --putStrLn
  
  
  -- Mission 1 bonus task: Do it with an one liner.
  -- Tip 1: Create pairs with list comprehension.
  -- Pro tip: I cheated by using a list instead of tuple to help handling the pairs.
  -- Tip 2: Remove duplicates.
  -- Tip 3: Create pretty print (apply pretty print function to each pair to create printable lines).
  -- Tip 4: Transform result lines into one String for putStrLn.
  
  
  
  ----------------------------------------------------------
  putStrLn "Mission 2: Attach a counter to each pair programmer."
  -- Mission 2: Attach a counter to each pair programmer.
  -- Task 1: Create a type (PairProgrammer) that contains name and counter.
  --         Remember "deriving Show" and put it outside main function.
  -- Task 2: Create a list of tuples with names in first slot and 0 in second slot.
  -- Tip: Hoogle: Find a function that combines two lists with a different type
  --              into a list of tuple of those types.
  -- Tip 2: Previous function truncates longer list ->
  --        Find a function that makes an infinite list from one thing.
  
  --putStrLn $ show nameCounterPairs
  
  
  -- Task 3: Create a list of PairProgrammers based on values created in previous step.
  -- Tip 1: Map nameCounterPairs' values into PairProgrammers.
  --let pps = 
  --putStrLn $ show pps
  
  
  -- Task 4: Create a function to update counter of a PairProgrammer.
  --putStrLn $ show $ updateCounter $ head pps
  
  -- Task 5: Create a function to update counter of PairProgrammer in a list.
  --         Use name to select a PairProgrammer that is updated.
  -- Note: If you use scands make sure the file encoding is UTF-8.
  --       In Komodo: Edit > Current File Settings... > Encoding
  {-
  let pps2 = updateInList "Esimerkki Elli" pps
  putStrLn $ show pps2
  let pps3 = updateInList "Esimerkki Elli" pps2
  putStrLn $ show pps3
  let pps4 = updateInList "Esimerkki Elli" pps3
  putStrLn $ show pps4
  let pps5 = updateInList "Esimerkki Esko" pps4
  putStrLn $ show pps5
  -}
  
  -- put close file handle here
  

------------------------------------------
-- Pure functions here
------------------------------------------
createPairs = undefined

createPair = undefined

prettyPrint = undefined


------------------------------------------
-- PairProgrammer stuff here
------------------------------------------
--data PairProgrammer = 

updateCounter = undefined

updateInList = undefined

updateIfMatch = undefined
