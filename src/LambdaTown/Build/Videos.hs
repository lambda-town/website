module LambdaTown.Build.Videos (buildAllVideos) where

import qualified Data.Text as T
import Development.Shake
import LambdaTown.Data
import Slick

buildVideo :: FilePath -> Action Video
buildVideo path = do
  content <- readFile' path
  markdownToHTML' . T.pack $ content

buildAllVideos :: Action [Video]
buildAllVideos = do
  pPaths <- getDirectoryFiles "." ["content/videos/*.md"]
  forP pPaths buildVideo
