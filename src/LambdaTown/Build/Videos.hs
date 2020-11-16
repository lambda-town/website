module LambdaTown.Build.Videos (buildAllVideos) where

import qualified Data.Text as T
import Development.Shake
import LambdaTown.Build.Commons
import LambdaTown.Data
import LambdaTown.Templates.Videos (renderVideo)
import Slick

buildVideo :: StyleSheets -> FilePath -> Action Video
buildVideo sheets path = do
  liftIO . putStrLn $ "Building video " <> path
  content <- readFile' path
  video <- markdownToHTML' . T.pack $ content
  let (Url vidUrl) = getUrl video
  writeHtml (outputFolder <> vidUrl) (renderVideo sheets video)
  return video

buildAllVideos :: StyleSheets -> Action [Video]
buildAllVideos sheets = do
  pPaths <- getDirectoryFiles "." ["content/videos/*.md"]
  forP pPaths (buildVideo sheets)
