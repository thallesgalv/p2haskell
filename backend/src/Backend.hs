module Backend where

import Common.Route
import Obelisk.Backend

import Database.PostgreSQL.Simple

getConn :: ConnectInfo
getConn = ConnectInfo "maquina"
                      5432 -- porta
                      "usuario"
                      "senha"
                      "banco"

backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve -> serve $ const $ return ()
  , _backend_routeEncoder = fullRouteEncoder
  }
