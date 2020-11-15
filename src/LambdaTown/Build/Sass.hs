module LambdaTown.Build.Sass (compileSheets, sassFolder) where

import Data.Functor
import Development.Shake
import Development.Shake.Classes
import Development.Shake.FilePath (dropExtension)
import LambdaTown.Build.Commons (outputFolder)
import LambdaTown.Data
import System.Directory (createDirectoryIfMissing)

-- | Compiles all the website's SASS sheets into CSS.
-- The StyleSheets record, containing the URL of every sheet is returned first
-- so that templates can access it without waiting for the sheets to be compiled.
-- Then the nested action is used to actually compile the sheets
compileSheets :: Action (StyleSheets, Action ())
compileSheets = do
  (homeUrl, compileHome) <- compileSheet "home.scss"
  let sheets = StyleSheets homeUrl
  let compileAll = parallel [compileHome] $> ()
  return (sheets, compileAll)

-- | Compiles a single SASS sheet into CSS.
-- The sheet's URL includes a hash for cache-busting
-- Returns the sheet's URL first so templates can access it without waiting for the sheet to be compiled,
-- and then the nested action is used to actually compile the sheet.
compileSheet :: FilePath -> Action (Url, Action ())
compileSheet input = do
  let inputFile = sassFolder <> input
  (outputPath, outputUrl) <- getSheetOutputPathAndUrl input
  return (outputUrl, compileSheet' inputFile outputPath)

-- | Calls the 'sass' command given an input path and and output path
compileSheet' :: FilePath -> FilePath -> Action ()
compileSheet' inputFile outputPath = do
  (liftIO . putStrLn) $ "Building Saas Sheet " <> inputFile <> " to " <> outputPath
  (liftIO . createDirectoryIfMissing True) (outputFolder <> "sass/")
  cmd_ "npm run sass" inputFile outputPath "--" "--style compressed"

-- | Generates an output path and URL for a compiled CSS sheet, given a path
-- to a Saas sheet. The url will include a hash computed from the content of the Saas sheet.
getSheetOutputPathAndUrl :: FilePath -> Action (FilePath, Url)
getSheetOutputPathAndUrl input = do
  fileContent <- readFile' $ sassFolder <> input
  let outputFile = outputFolder <> "sass/" <> dropExtension input <> "." <> (show . hash) fileContent <> ".css"
  let outputUrl = Url $ drop (length outputFolder) outputFile
  return (outputFile, outputUrl)

sassFolder :: FilePath
sassFolder = "src/sass/"
