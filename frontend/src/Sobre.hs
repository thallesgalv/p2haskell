{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Sobre where

import Control.Monad
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import Language.Javascript.JSaddle (eval, liftJSM)

import Obelisk.Frontend
import Obelisk.Configs
import Obelisk.Route
import Obelisk.Generated.Static

import Reflex.Dom.Core

import Common.Api
import Common.Route


sobre :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
sobre = do
elAttr "section" ("id" =: "sobre") $ do
  el "h1" $ text "Sobre"
  el "p" $ text "Projeto desenvolvido pelos alunos Felipe Gameiro e Thalles Galvão"
  return ()
  