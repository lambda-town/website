{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Videos (renderVideo) where

import LambdaTown.Data
import LambdaTown.Templates.Layout
import LambdaTown.Templates.Nav
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

renderVideo :: StyleSheets -> Video -> Html
renderVideo StyleSheets {videoPageSheet} vid =
  layout opts $ do
    navbar
    narrowContainer $ do
      renderPlayer vid
      ((h1 ! class_ "my-4") . toHtml . vidTitle) vid
      (preEscapedToHtml . vidContent) vid
  where
    pageTitle = vidTitle vid <> "(Video) - Lambda Town"
    styleSheets = [videoPageSheet]
    opts = layoutOpts {pageTitle, styleSheets}

renderPlayer :: Video -> Html
renderPlayer Video {vidYoutubeId, vidTitle} =
  let (YoutubeId id') = vidYoutubeId
      src' = toValue $ "https://www.youtube.com/embed/" <> id' <> "?rel=0"
      iframe' = iframe ! src src' ! (A.title . toValue) vidTitle ! customAttribute "allowfullscreen" mempty $ mempty
   in H.div ! class_ "ratio ratio-16x9 mt-3 mt-lg-5" $ iframe'
