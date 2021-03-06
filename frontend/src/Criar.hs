{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Criar where

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

import Components

criar :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
criar = do
elAttr "section" ("id" =: "criar") $ do
  el "h1" $ text "Criar Tarefa"
  elAttr "div" ("class" =: "form") $ do
    input
    submit
  return ()
  