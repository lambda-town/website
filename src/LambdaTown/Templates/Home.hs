{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Home (renderHome) where

import LambdaTown.Data (HomeContent (..), StyleSheets (..), Video)
import LambdaTown.Templates.Layout
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

renderHome :: HomeContent -> StyleSheets -> Html
renderHome HomeContent {homeHeadline} StyleSheets {homepageSheet} = layout opts $ do
  H.div ! A.id "hero" $ do
    (h1 . toHtml) homeHeadline
  where
    pageTitle = "LambdaTown"
    styleSheets = [homepageSheet]
    opts = layoutOpts {pageTitle, styleSheets}

renderVideo :: Video -> Html
renderVideo video = do
  "A video"
