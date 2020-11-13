{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Home where

import LambdaTown.Data (HomeContent (..), Video)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

renderVideo :: Video -> Html
renderVideo video = do
  "A video"

renderHome :: HomeContent -> Html
renderHome content = docTypeHtml $ do
  H.head $ do
    H.title "Lambda town"
  H.body $ do
    toHtml $ homeHeadline content
