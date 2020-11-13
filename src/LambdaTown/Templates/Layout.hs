{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Layout where

import Control.Monad (forM_)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

data LayoutOpts = LayoutOpts
  { pageTitle :: String,
    styleSheets :: [FilePath]
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
    forM_ styleSheets renderStyleSheet
  H.body $ do
    toHtml pageContent
  where
    renderStyleSheet path = link ! rel "stylesheet" ! href ("/" <> toValue path)
