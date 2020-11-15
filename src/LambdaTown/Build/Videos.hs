module LambdaTown.Build.Videos (buildAllVideos) where

import qualified Data.Text as T
import Development.Shake
import LambdaTown.Data
import Slick

buildVideo :: FilePath -> Action Video
buildVideo path = do
  liftIO . putStrLn $ "Building video " <> path
  content <- readFile' path
  video <- markdownToHTML' . T.pack $ content
  -- let videoUrl = getUrl video
  return video

buildAllVideos :: Action [Video]
buildAllVideos = do
  pPaths <- getDirectoryFiles "." ["content/videos/*.md"]
  forP pPaths buildVideo
