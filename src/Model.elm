module Model exposing (..)

import Message exposing (..)
import Util exposing (getStatus)

type alias Model =
  { status : List (String, String)
  }

init : (Model, Cmd Msg)
init =
  let
    model = Model []
    cmds  = getStatus
  in
    (model, cmds)
