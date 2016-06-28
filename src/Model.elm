module Model exposing (..)

import Message exposing (Msg(GetStatus))
import Util exposing (getStatus)
import Time exposing (Time)

type alias Service =
  String

type alias Health =
  Maybe String

type alias Status =
  List (Service, Health, Health)

type alias Model =
  { message  : String
  , status   : Status
  , lastPoll : Time
  }

init : (Model, Cmd Msg)
init =
  let
    model = Model "Fetching ..." [] 0
    cmds = getStatus
  in
    (model, cmds)
