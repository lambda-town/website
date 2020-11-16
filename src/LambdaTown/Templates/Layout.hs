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

narrowContainer :: Html -> Html
narrowContainer =
  (H.div ! class_ "container-fluid")
    . (H.div ! class_ "row justify-content-center")
    . (H.div ! class_ "col-md-9 col-lg-8 col-xl-6 p-2 p-lg-3")

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
    link ! rel "stylesheet" ! href "https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap"
    forM_ styleSheets renderStyleSheet
  H.body $ do
    toHtml pageContent
    script ! src "https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" $ mempty
    script ! src "https://cdnjs.cloudflare.com/ajax/libs/instant.page/5.1.0/instantpage.min.js" $ mempty
    script "feather.replace()"
  where
    renderStyleSheet path = link ! rel "stylesheet" ! href ("/" <> toValue path)
