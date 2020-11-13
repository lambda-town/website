module LambdaTown.Build.Home where

import qualified Data.Yaml as Y
import Development.Shake
import LambdaTown.Build.Commons (decodeYaml, outputFolder, writeHtml)
import LambdaTown.Data (HomeContent)
import LambdaTown.Templates.Home (renderHome)

getHomeContent :: Action HomeContent
getHomeContent = readFile' "content/home-content.yml" >>= decodeYaml

buildHome :: Action ()
buildHome = do
  liftIO $ putStrLn "Building homepage"
  content <- getHomeContent
  let template = renderHome content
  writeHtml (outputFolder <> "/index.html") template
