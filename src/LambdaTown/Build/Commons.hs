module LambdaTown.Build.Commons where

import Data.Aeson (FromJSON)
import Data.ByteString.Builder (stringUtf8, toLazyByteString)
import Data.ByteString.Lazy (toStrict)
import Data.Yaml (decodeThrow)
import Development.Shake (Action, liftIO, writeFile')
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.String (renderHtml)

decodeYaml :: FromJSON a => String -> Action a
decodeYaml input = output
  where
    bs = (toStrict . toLazyByteString . stringUtf8) input
    output = (liftIO . decodeThrow) bs

writeHtml :: FilePath -> Html -> Action ()
writeHtml path = writeFile' path . renderHtml

outputFolder :: FilePath
outputFolder = "out/"
