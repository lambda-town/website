module Main where

import Data.Functor (($>))
import Development.Shake
import LambdaTown.Build.Commons (removeEverything)
import LambdaTown.Build.Home (buildHome)
import LambdaTown.Build.Sass (compileSheets)
import Slick.Shake (slick)

buildEverything :: Action ()
buildEverything = do
  removeEverything
  sheets <- compileSheets
  buildHome sheets

main :: IO ()
main = shake shakeOptions $ action buildEverything
