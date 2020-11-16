{-# LANGUAGE OverloadedStrings #-}

module LambdaTown.Templates.Nav where

import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

navbar :: Html
navbar = (nav ! class_ "navbar navbar-dark") . (H.div ! class_ "container-xl") $ do
  a ! href "/" ! class_ "navbar-brand" $ "Lambda Town"
