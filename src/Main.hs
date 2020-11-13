module Main where

import LambdaTown.Build.Home
import Slick.Shake (slick)
import Development.Shake.Forward ( shakeArgsForward )
import           Development.Shake

main :: IO ()
main = do
  let shOpts = shakeOptions { shakeVerbosity = Chatty, shakeLintInside = ["\\"]}
  shakeArgsForward shOpts buildHome
