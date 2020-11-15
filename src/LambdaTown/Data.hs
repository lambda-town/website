{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Data where

import Data.Aeson
import Data.Char (isAlphaNum, toLower)
import Data.String (IsString)
import qualified Data.Text as T
import GHC.Generics (Generic)
import Text.Pandoc
import Text.Blaze.Html5 (ToValue)

{-
  Videos
 -}

-- | This represents the id of a video hosted on Youtube, e.g. "YWhrrfP3718"
newtype YoutubeId = YoutubeId String
  deriving (Eq, Show, IsString, FromJSON)

-- | A type representing a single video
data Video = Video
  { vidTitle :: String,
    vidYoutubeId :: YoutubeId,
    vidTags :: [Tag],
    vidContent :: String,
    vidExcerpt :: String
  }

instance FromJSON Video where
  parseJSON = withObject "video" $ \v -> do
    vidTitle <- v .: "title"
    vidYoutubeId <- v .: "youtubeId"
    vidTags <- v .:? "tags" .!= []
    vidContent <- v .: "content"
    let vidExcerpt = htmlToExcerpt 145 vidContent
    return $ Video {vidTitle, vidYoutubeId, vidTags, vidContent, vidExcerpt}

instance HasSlug Video where slug = stringToSlug . vidTitle

instance HasUrl Video where getUrl = getUrl . VideoPage . slug

-- | Retrieve a URL to a video thumbnail from its YoutubeId
getThumbnailUrl :: YoutubeId -> Url
getThumbnailUrl (YoutubeId id) = Url $ "https://img.youtube.com/vi/" <> id <> "/maxresdefault.jpg"

{-
  Pages
-}

-- | This represents the static content of the home page,
-- typically obtained by reading a file
-- This exludes links to videos which are generated from data in the videos folder
data HomeContent = HomeContent
  { homeHeadline :: String,
    heroText :: String
  }
  deriving (Show, Generic)

instance FromJSON HomeContent where
  parseJSON = withObject "homeContent" $ \o ->
    HomeContent
      <$> o .: "headline"
      <*> o .: "heroText"

-- | This represents compiled style sheets for the entire website.
-- The plan is to have at most one sheet per page if possible, to reduce load times
-- This record is built once every sheet has been processed, and then passed to templates that need it.
newtype StyleSheets = StyleSheets
  { homepageSheet :: Url
  }

{-
  Common types and classes
-}

newtype Slug = Slug String
  deriving (Eq, Show, IsString, FromJSON)

class HasSlug entity where
  slug :: entity -> Slug

newtype Tag = Tag String
  deriving (Eq, Show, IsString, FromJSON)

newtype Url = Url String
  deriving (Eq, Show, IsString, ToValue)

class HasUrl entity where
  getUrl :: entity -> Url

-- | A type to represent routes safely. Obtaining a url for a route
-- is achieved using the HasUrl instance.
data Route
  = HomePage
  | VideoPage Slug

instance HasUrl Route where
  getUrl HomePage = Url "/index.html"
  getUrl (VideoPage (Slug slug)) = Url $ "/video/" <> slug <> ".html"

htmlToExcerpt :: Int -> String -> String
htmlToExcerpt size input = either show id $
  runPure $ do
    doc <- readHtml def (T.pack input)
    plain <- writePlain def doc
    (return . take size . T.unpack) plain

stringToSlug :: String -> Slug
stringToSlug input = Slug $ input >>= char
  where
    char ' ' = ['-']
    char c | isAlphaNum c = [c]
    char _ = []
