{-# LANGUAGE LambdaCase, GADTs, OverloadedStrings #-}
module Backend where

import Common.Route
import Obelisk.Backend
import Database.PostgreSQL.Simple
import Data.Text
import Obelisk.Route
import Snap.Core
import Control.Monad.IO.Class (liftIO)
import qualified Data.Aeson as A

import Database.PostgreSQL.Simple

migration :: Query
migration = "CREATE TABLE IF NOT EXISTS todo\
            \ (id SERIAL PRIMARY KEY, tarefa TEXT NOT NULL)"

getConn :: ConnectInfo
getConn = ConnectInfo "ec2-52-86-56-90.compute-1.amazonaws.com"
                      5432 -- porta
                      "nekyxozewcrclx"
                      "e0464e50ceac30efd6c8e79293ea27808cfca9f70679eeaf09bff2279dd8c5ea"
                      "d5du3q4bgkidfd"

backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve -> do
    dbcon <- connect getConn
    serve $ do
        \case
          BackendRoute_Todo :/ () -> do
            Just tarefa <- A.decode <$> readRequestBody 2000
            liftIO $ do
                execute_ dbcon migration
                execute dbcon "INSERT INTO todo (tarefa) VALUES (?)" [tarefa :: Text]
            modifyResponse $ setResponseStatus 200 "OK"
          _ -> return ()
  , _backend_routeEncoder = fullRouteEncoder
  }
