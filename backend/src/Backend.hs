module Backend where

import Common.Route
import Obelisk.Backend

import Database.PostgreSQL.Simple

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
    serve $ const $ return ()
  , _backend_routeEncoder = fullRouteEncoder
  }
