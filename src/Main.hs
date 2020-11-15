module Main where

import Data.Functor (($>))
import Development.Shake
import LambdaTown.Build.Commons (removeEverything)
import LambdaTown.Build.Home (buildHome)
import LambdaTown.Build.Sass (compileSheets)
import LambdaTown.Build.Videos (buildAllVideos)
import Slick.Shake (slick)

buildEverything :: Action ()
buildEverything = do
  removeEverything
  (sheets, doCompileSheets) <- compileSheets
  videos <- buildAllVideos
  par (buildHome sheets videos) doCompileSheets
  return ()

main :: IO ()
main = shake shakeOptions $ action buildEverything
