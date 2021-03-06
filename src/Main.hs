module Main where

import Development.Shake
import LambdaTown.Build.Commons (removeEverything, copyStaticFiles)
import LambdaTown.Build.Home (buildHome)
import LambdaTown.Build.Sass (compileSheets)
import LambdaTown.Build.Videos (buildAllVideos)

buildEverything :: Action ()
buildEverything = do
  removeEverything
  copyStaticFiles
  (sheets, doCompileSheets) <- compileSheets
  videos <- buildAllVideos sheets
  _ <- par (buildHome sheets videos) doCompileSheets
  return ()

main :: IO ()
main = shake shakeOptions $ action buildEverything
