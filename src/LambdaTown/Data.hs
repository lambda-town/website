{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module LambdaTown.Data where

import Data.Aeson (FromJSON (..), Options (..), defaultOptions, genericParseJSON)
import Data.Aeson.Casing (aesonPrefix, camelCase)
import Data.String (IsString)
import GHC.Generics (Generic)

newtype YoutubeId = YoutubeId String
  deriving (Eq, Show, IsString)

newtype Tag = Tag String
  deriving (Eq, Show, IsString)

data Video = Video
  { vidTitle :: String,
    vidYoutubeId :: YoutubeId,
    tags :: [Tag]
  }

newtype HomeContent = HomeContent
  { homeHeadline :: String
  }
  deriving (Show, Generic)

instance FromJSON HomeContent where
  parseJSON = genericParseJSON $ aesonPrefix camelCase
