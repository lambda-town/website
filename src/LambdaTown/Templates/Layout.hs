{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Layout where

import Control.Monad (forM_)
import LambdaTown.Data (Url)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

data LayoutOpts = LayoutOpts
  { pageTitle :: String,
    styleSheets :: [Url]
  }


layoutOpts :: LayoutOpts
layoutOpts =
  LayoutOpts
    { pageTitle = "Lambda Town",
      styleSheets = []
    }

layout :: LayoutOpts -> Html -> Html
layout LayoutOpts {pageTitle, styleSheets} pageContent = docTypeHtml $ do
  H.head $ do
    (H.title . toHtml) pageTitle
    meta ! name "viewport" ! content "width=device-width, initial-scale=1"
    forM_ styleSheets renderStyleSheet
  H.body $ do
    toHtml pageContent
    script ! src "https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" $ mempty
    script "feather.replace()"
  where
    renderStyleSheet path = link ! rel "stylesheet" ! href ("/" <> toValue path)
