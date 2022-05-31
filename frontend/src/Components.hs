{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Components where

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
import Control.Monad.Fix

import Text.Read
import Data.Maybe


input :: (DomBuilder t m, PostBuild t m) => m ()
input = do
    elAttr "div" ("class" =: "inputContainer") $ do
      el "label" (text "Adicione uma tarefa: ")
      task <- inputElement def -- m (Dynamic Text)
      text " "
      -- dynText (zipDynWith (<>) (_inputElement_value task))

submit :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
submit = do
    elAttr "button" ("class" =: "submit") (text "Enviar")
    return ()