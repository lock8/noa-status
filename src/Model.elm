module Model exposing (..)

import Message exposing (Msg)

type alias Model =
  { status : List (String, String)
  }

init : (Model, Cmd Msg)
init = (Model []) ! []
