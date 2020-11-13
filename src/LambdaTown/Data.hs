{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Data where

import Data.Aeson
import Data.String (IsString)
import GHC.Generics (Generic)

newtype YoutubeId = YoutubeId String
  deriving (Eq, Show, IsString, FromJSON)

newtype Tag = Tag String
  deriving (Eq, Show, IsString, FromJSON)

data Video = Video
  { vidTitle :: String,
    vidYoutubeId :: YoutubeId,
    vidTags :: [Tag],
    vidContent :: String
  }

instance FromJSON Video where
  parseJSON = withObject "video" $ \v ->
    Video
      <$> v .: "title"
      <*> v .: "youtubeId"
      <*> v .:? "tags" .!= []
      <*> v .: "content"

newtype HomeContent = HomeContent
  { homeHeadline :: String
  }
  deriving (Show, Generic)

instance FromJSON HomeContent where
  parseJSON = withObject "homeContent" $ \o ->
    HomeContent
      <$> o .: "headline"


newtype StyleSheets = StyleSheets {
  homepageSheet :: FilePath
}