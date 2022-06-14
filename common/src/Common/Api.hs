{-# LANGUAGE DeriveGeneric #-}
{-# language DeriveAnyClass #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Common.Api where
import Data.Aeson
import Data.Text (Text)
import GHC.Generics (Generic)

data Todo = Todo Text deriving (Generic, ToJSON, FromJSON)

commonStuff :: String
commonStuff = "Here is a string defined in Common.Api"
