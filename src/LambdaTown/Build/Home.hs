module LambdaTown.Build.Home where

import qualified Data.Yaml as Y
import Development.Shake
import LambdaTown.Build.Commons (decodeYaml, outputFolder, writeHtml)
import LambdaTown.Data (HomeContent, StyleSheets)
import LambdaTown.Templates.Home (renderHome)

getHomeContent :: Action HomeContent
getHomeContent = readFile' "content/home-content.yml" >>= decodeYaml

buildHome :: StyleSheets -> Action ()
buildHome sheets = do
  liftIO $ putStrLn "Building homepage"
  content <- getHomeContent
  let template = renderHome content sheets
  writeHtml (outputFolder <> "/index.html") template
