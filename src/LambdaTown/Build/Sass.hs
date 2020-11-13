module LambdaTown.Build.Sass (compileSheets, sassFolder) where

import Data.Functor
import qualified Data.Map
import Development.Shake
import Development.Shake.Classes
import Development.Shake.FilePath (dropExtension)
import LambdaTown.Build.Commons (outputFolder)
import LambdaTown.Data
import System.Directory (createDirectoryIfMissing)

compileSheets :: Action StyleSheets
compileSheets = StyleSheets <$> compileSheet "home.scss"

compileSheet :: FilePath -> Action FilePath
compileSheet input =
  do
    let inputFile = sassFolder <> input
    fileContent <- readFile' inputFile
    let outputFile = outputFolder <> "sass/" <> dropExtension input <> "." <> (show . hash) fileContent <> ".css"
    let outputUrl = drop (length outputFolder) outputFile
    (liftIO . putStrLn) $ "Building Saas Sheet " <> inputFile <> " to " <> outputFile
    (liftIO . createDirectoryIfMissing True) (outputFolder <> "sass/")
    cmd_ "sass" inputFile outputFile "--style compressed"
    return outputUrl

sassFolder :: FilePath
sassFolder = "src/sass/"
