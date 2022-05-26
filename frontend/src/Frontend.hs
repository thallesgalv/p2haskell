{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Frontend where

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

menu :: DomBuilder t m => m ()
menu = do
  el "header" $ do
    el "nav" $ do
      el "ul" $ do
        el "li" (text "Ver tarefas")
        el "li" (text "Criar tarefa")
  el "h1" $ text "Todo List P2 Haskell"
  el "section" $ do
    el "h2" $ text "Lista de Tarefas:"
    el "ul" $ do
      el "li" (text "Tarefa 1")
      el "li" (text "Tarefa 2")
      el "li" (text "Tarefa 3")

-- This runs in a monad that can be run on the client or the server.
-- To run code in a pure client or pure server context, use one of the
-- `prerender` functions.
frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      
      el "title" $ text "Todo List P2 Haskell"
      elAttr "link" ("href" =: $(static "main.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
  , _frontend_body = do
      menu
      el "p" $ text $ T.pack commonStuff
      
      -- `prerender` and `prerender_` let you choose a widget to run on the server
      -- during prerendering and a different widget to run on the client with
      -- JavaScript. The following will generate a `blank` widget on the server and
      -- print "Hello, World!" on the client.
      prerender_ blank $ liftJSM $ void $ eval ("console.log('Hello, World!')" :: T.Text)

      el "div" $ do
        exampleConfig <- getConfig "common/example"
        case exampleConfig of
          Nothing -> text "No config file found in config/common/example"
          Just s -> text $ T.decodeUtf8 s
      return ()
  }
