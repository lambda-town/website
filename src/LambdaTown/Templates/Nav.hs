{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Nav where

import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

navbar :: Html
navbar = (nav ! class_ "navbar navbar-dark") . (H.div ! class_ "container-xl") $ do
  a ! href "/" ! class_ "navbar-brand" $ do
    img ! alt "Lambda Town Logo" ! src "/assets/navbar-icon.png"
    "lambda.town"

footer :: Html
footer = (H.div ! A.id "footer") . (H.div ! class_ "container-xl") . (H.div ! class_ "row") $ do
  H.div ! class_ "col-md-5" $ do
    p ! class_ "brand" $ do
      img ! alt "Lambda Town Logo" ! src "/assets/navbar-icon.png"
      "lambda.town"
    p $ do
      "This website is made with love, and built with Haskell"
      br
      a ! href "https://github.com/lambda-town/website" $ "See the code"