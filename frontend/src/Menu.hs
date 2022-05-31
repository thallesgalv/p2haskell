{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Menu where

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

import Text.Read
import Data.Maybe
import Control.Monad.Fix

import Tarefas
import Criar
import Sobre

data Pagina = Pagina0 | Pagina1 | Pagina2 | Pagina3

clickLi :: DomBuilder t m => Pagina -> T.Text -> m (Event t Pagina)
clickLi p t = do
    (ev, _) <- el' "li" (elAttr "a" ("href" =: "#") (text t))
    return ((\_ -> p) <$> domEvent Click ev)

menuLi :: (DomBuilder t m, MonadHold t m) => m (Dynamic t Pagina)
menuLi = do
    evs <- el "header" $ do
        el "nav" $ do
          el "ul" $ do
              p1 <- clickLi Pagina1 "Tarefas"
              p2 <- clickLi Pagina2 "Criar Tarefas"
              p3 <- clickLi Pagina3 "Sobre"
              return (leftmost [p1,p2,p3])
    holdDyn Pagina0 evs

currPag :: (DomBuilder t m, MonadHold t m, PostBuild t m, MonadFix m) => Pagina -> m ()
currPag p = case p of
    Pagina0 -> tarefas
    Pagina1 -> tarefas
    Pagina2 -> criar
    Pagina3 -> sobre

mainPag :: (DomBuilder t m, MonadHold t m, PostBuild t m, MonadFix m) => m ()
mainPag = do
    pag <- menuLi
    dyn_ $ currPag <$> pag