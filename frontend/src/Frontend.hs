{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell, ScopedTypeVariables #-}

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
import Menu
import Control.Monad;

getPath :: T.Text
getPath = renderBackendRoute checFullREnc $ BackendRoute_Todo :/ ()

nomeRequest :: T.Text -> XhrRequest T.Text
nomeRequest s = postJson getPath (Todo s)

req :: ( DomBuilder t m, Prerender t m) => m ()
req = do
    inputEl <- inputElement def
    (submitBtn,_) <- el' "button" (text "Inserir")
    let click = domEvent Click submitBtn
    let nm = tag (current $ _inputElement_value inputEl) click
    _ :: Dynamic t (Event t (Maybe T.Text)) <- prerender
        (pure never)
        (fmap decodeXhrResponse <$> performRequestAsync (nomeRequest <$> nm))
    return ()

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      el "title" $ text "Todo List P2 Haskell"
      elAttr "link" ("href" =: $(static "main.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
  , _frontend_body = do
      elAttr "section" ("id" =: "criar") $ do
       el "h1" $ text "Criar Tarefa"
       elAttr "div" ("class" =: "form") $ do
        req 
      -- aqui iria o mainPag. Mas não consigo renderizar esse req dentro do Create.hs (o req está exatamente igual ao demonstrado em aula)
  
      return ()
  }
