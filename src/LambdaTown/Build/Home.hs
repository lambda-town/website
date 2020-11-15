module LambdaTown.Build.Home where

import qualified Data.Yaml as Y
import Development.Shake
import LambdaTown.Build.Commons (decodeYaml, outputFolder, writeHtml)
import LambdaTown.Data
import LambdaTown.Templates.Home (renderHome)

getHomeContent :: Action HomeContent
getHomeContent = readFile' "content/home-content.yml" >>= decodeYaml

buildHome :: StyleSheets -> [Video] -> Action ()
buildHome sheets videos = do
  liftIO $ putStrLn "Building homepage"
  let (Url route) = getUrl HomePage
  content <- getHomeContent
  let template = renderHome content sheets videos
  writeHtml (outputFolder <> route) template
