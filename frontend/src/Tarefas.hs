{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Tarefas where

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


tarefas :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
tarefas = do
elAttr "section" ("id" =: "tarefas") $ do
  el "h1" $ text "Tarefas"
  elAttr "div" ("class" =: "card") $ do
    el "h2" $ text "Lista de Tarefas:"
    el "ul" $ do
      el "li" (text "Tarefa 1")
      el "li" (text "Tarefa 2")
      el "li" (text "Tarefa 3")
  return ()

  