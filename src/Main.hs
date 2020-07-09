module Main where
import Data.Char
import Data.Validation

newtype Username = Username String deriving Show
newtype Password = Password String deriving Show
-- {-# LANGUAGE GeneralizedNewtypeDeriving #-}
newtype Error = Error [String] deriving Show
instance Semigroup Error where
  Error xs <> Error ys = Error (xs <> ys)
data User = User Username Password deriving Show

requireAlphaNum :: String -> Validation Error String
requireAlphaNum "" = Success ""
requireAlphaNum xs =
  if all isAlpha xs then Success xs else Failure (Error ["Does not have alpha numerals"])

cleanWhiteSpaces :: String -> Validation Error String
cleanWhiteSpaces "" = Success ""
cleanWhiteSpaces (x:xs) =
  if isSpace x then cleanWhiteSpaces xs else Success xs

checkLength :: Int -> String -> Validation Error String
checkLength n xs =
  if n < 1 then
    Failure (Error ["invalid length"])
  else
    if length xs < n then
      Failure (Error ["too small"])
    else
      Success xs

-- *> = f a -> f b -> f b
-- <* = f a -> f b -> f a
validateUsername :: Username -> Validation Error Username
validateUsername (Username username) =
  case requireAlphaNum username *> cleanWhiteSpaces username of
    Failure errorMsg -> Failure (Error ["Username error -> "] <> errorMsg)
    Success username ->
      case checkLength 10 username of
        Failure error -> Failure (Error ["Username error -> "] <> error)
        Success xs -> Success (Username xs)
        

validatePassword :: Password -> Validation Error Password
validatePassword (Password password) =
    case requireAlphaNum password *> cleanWhiteSpaces password of
    Failure error -> Failure (Error ["Password error -> "] <> error)
    Success password ->
      case checkLength 8 password of
        Failure error -> Failure (Error ["Password error -> "] <> error)
        Success xs -> Success (Password xs)

makeUser :: Username -> Password -> Validation Error User
makeUser username password =
  User <$> validateUsername username <*> validatePassword password
  

printUser :: User -> IO ()
printUser (User username password) =
  putStrLn ("Hello " ++ show username ++ " Your password is " ++ show password)
  -- putStrLn ("Password is " ++ show password
  --print ("Welcome " ++ (show username))
  --print ("Password is " ++ (show password))

makeUserTmpPassword :: Username -> Validation Error User
makeUserTmpPassword name =
  User <$> validateUsername name
  <*> Success (Password "temporaryPassword")

displayUser :: Username -> Password -> IO ()
displayUser username password =
  case makeUser username password of
    Failure (Error errorMsg) -> putStr (unlines errorMsg)
    Success user -> printUser user

main :: IO ()
main = do
  putStrLn "Username: "
  username <- Username <$> getLine
  putStrLn "Password: "
  password <- Password <$> getLine

  displayUser username password
  
