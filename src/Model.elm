module Model exposing (..)

import Message exposing (Msg(GetStatus))
import Command exposing (statusTask)
import Time exposing (Time)

type Service
  = Velodrome
  | Locksocket

type Environment
  = Testing
  | Production

type Condition
  = Healthy
  | Unhealthy
  | Down

type alias Status =
  { service     : Service
  , environment : Environment
  , condition   : Condition
  }

type alias Model =
  { message  : String
  , status   : List Status
  , lastPoll : Time
  }

init : (Model, Cmd Msg)
init =
  let
    model = Model "Fetching ..." [] 0
    cmds = statusTask
  in
    (model, cmds)
