{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Home (renderHome) where

import Control.Monad (forM_)
import LambdaTown.Data
import LambdaTown.Templates.Layout
import LambdaTown.Templates.Nav (navbar)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

renderHome :: HomeContent -> StyleSheets -> [Video] -> Html
renderHome
  HomeContent {homeHeadline, heroText}
  StyleSheets {homepageSheet}
  videos =
    layout opts $ do
      navbar
      H.div ! A.id "hero" $ do
        H.div ! A.id "hero-content" $ do
          (h1 . toHtml) homeHeadline
          (p . preEscapedToHtml) heroText
      H.div ! A.id "main-content" $ do
        H.div ! class_ "row justify-content-start" $ forM_ videos renderVideo
    where
      pageTitle = "Lambda Towm, functional programming made approachable"
      styleSheets = [homepageSheet]
      opts = layoutOpts {pageTitle, styleSheets}

renderVideo :: Video -> Html
renderVideo vid = do
  let Video {vidTitle, vidYoutubeId, vidExcerpt} = vid
  let (Url imgUrl) = getThumbnailUrl vidYoutubeId
  let link' = a ! (href . toValue . getUrl) vid
  H.div ! class_ "col-sm-12 col-md-4" $ do
    H.div ! class_ "video-card" $ do
      link' $ do
        img ! class_ "card-img-top rounded" ! (src . toValue) imgUrl ! (alt . toValue) vidTitle
      H.div ! class_ "card-body" $ do
        link' $ h5 ! class_ "card-title" $ toHtml vidTitle
        (p . toHtml) (vidExcerpt <> "...")
        link' ! class_ "btn btn-rounded btn-outline-secondary" $ do
          i ! dataAttribute "feather" "play" $ mempty
          "See the video"
