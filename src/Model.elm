module Model exposing (..)

import Message exposing (Msg(GetStatus))
import Util exposing (getStatus)
import Time exposing (Time)
import Task exposing (Task)

type alias Status = (String, String)

type alias Model =
  { message  : String
  , status   : List Status
  , lastPoll : Time
  }

init : (Model, Cmd Msg)
init =
  let
    model    = Model "Fetching ..." [] 0
    cmds     = getStatus
  in
    (model, cmds)
