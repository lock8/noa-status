module Update exposing (update)

import Model exposing (Model)
import Message exposing (..)
import Util exposing (getStatus)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      { model | status = [] } ! []
    GetStatus ->
      model ! [getStatus]
    Error err ->
      model ! []
    Fetched resp ->
      { model | status = resp.data } ! []
